CREATE OR REPLACE FUNCTION attachments_after_delete() RETURNS trigger AS
$$
  BEGIN
    UPDATE members SET
      attachments_count = attachments_count - 1,
      attachments_size = attachments_size - OLD.size
      WHERE id IN (SELECT member_id FROM messages WHERE id = OLD.message_id);

    UPDATE channels SET
      attachments_count = attachments_count - 1,
      attachments_size = attachments_size - OLD.size
      WHERE id IN (SELECT channel_id FROM messages WHERE id = OLD.message_id);

    RETURN NULL;
  END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION attachments_after_insert() RETURNS trigger AS
$$
  BEGIN
    UPDATE members SET
      attachments_count = attachments_count + 1,
      attachments_size = attachments_size + NEW.size
      WHERE id IN (SELECT member_id FROM messages WHERE id = NEW.message_id);

    UPDATE channels SET
      attachments_count = attachments_count + 1,
      attachments_size = attachments_size + NEW.size
      WHERE id IN (SELECT channel_id FROM messages WHERE id = NEW.message_id);

    RETURN NULL;
  END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION members_roles_after_delete() RETURNS trigger AS
$$
  BEGIN
    UPDATE members SET roles_count = roles_count - 1
      WHERE id = OLD.member_id;

    UPDATE roles SET members_count = members_count - 1
      WHERE id = OLD.role_id;

    RETURN NULL;
  END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION members_roles_after_insert() RETURNS trigger AS
$$
  BEGIN
    UPDATE members SET roles_count = roles_count + 1
      WHERE id = NEW.member_id;

    UPDATE roles SET members_count = members_count + 1
      WHERE id = NEW.role_id;
    RETURN NULL;
  END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION mentions_after_delete() RETURNS trigger AS
$$
BEGIN
  UPDATE members SET mentionings_count = mentionings_count - 1
    WHERE id IN (SELECT member_id FROM messages WHERE id = OLD.message_id);

  UPDATE members SET mentions_count = mentions_count - 1
    WHERE id = OLD.member_id;

  RETURN NULL;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION mentions_after_insert() RETURNS trigger AS
$$
BEGIN
  UPDATE members SET mentionings_count = mentionings_count + 1
    WHERE id IN (SELECT member_id FROM messages WHERE id = NEW.message_id);

  UPDATE members SET mentions_count = mentions_count + 1
    WHERE id = NEW.member_id;

  RETURN NULL;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION role_mentions_after_delete() RETURNS trigger AS
$$
BEGIN
  UPDATE members SET mentionings_count = mentionings_count - 1
    WHERE id IN (SELECT member_id FROM messages WHERE id = OLD.message_id);

  UPDATE roles SET mentions_count = mentions_count - 1
    WHERE id = OLD.role_id;

  RETURN NULL;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION role_mentions_after_insert() RETURNS trigger AS
$$
BEGIN
  UPDATE members SET mentionings_count = mentionings_count + 1
    WHERE id IN (SELECT member_id FROM messages WHERE id = NEW.message_id);

  UPDATE roles SET mentions_count = mentions_count + 1
    WHERE id = NEW.role_id;

  RETURN NULL;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION messages_after_delete() RETURNS trigger AS
$$
  BEGIN
    UPDATE members SET messages_count = messages_count - 1
      WHERE id = OLD.member_id;

    UPDATE channels SET messages_count = messages_count - 1
      WHERE id = OLD.channel_id;

    RETURN NULL;
  END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION messages_after_insert() RETURNS trigger AS
$$
  BEGIN
    UPDATE members SET messages_count = messages_count + 1
      WHERE id = NEW.member_id;

    UPDATE channels SET messages_count = messages_count + 1
      WHERE id = NEW.channel_id;

    RETURN NULL;
  END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION messages_after_update_edited_timestamp() RETURNS trigger AS
$$
  BEGIN
    UPDATE members SET message_edits_count = message_edits_count + 1
      WHERE id = OLD.member_id;

    UPDATE channels SET message_edits_count = message_edits_count + 1
      WHERE id = OLD.channel_id;

    RETURN NULL;
  END;
$$ LANGUAGE plpgsql;



CREATE TRIGGER attachments_after_delete
  AFTER DELETE ON attachments
  FOR EACH ROW
  EXECUTE PROCEDURE attachments_after_delete();

CREATE TRIGGER attachments_after_insert
  AFTER INSERT ON attachments
  FOR EACH ROW
  EXECUTE PROCEDURE attachments_after_insert();

CREATE TRIGGER members_roles_after_delete
  AFTER DELETE ON members_roles
  FOR EACH ROW
  EXECUTE PROCEDURE members_roles_after_delete();

CREATE TRIGGER members_roles_after_insert
  AFTER INSERT ON members_roles
  FOR EACH ROW
  EXECUTE PROCEDURE members_roles_after_insert();

CREATE TRIGGER mentions_after_delete
  AFTER DELETE ON mentions
  FOR EACH ROW
  EXECUTE PROCEDURE mentions_after_delete();

CREATE TRIGGER mentions_after_insert
  AFTER INSERT ON mentions
  FOR EACH ROW
  EXECUTE PROCEDURE mentions_after_insert();

CREATE TRIGGER role_mentions_after_delete
  AFTER DELETE ON role_mentions
  FOR EACH ROW
  EXECUTE PROCEDURE role_mentions_after_delete();

CREATE TRIGGER role_mentions_after_insert
  AFTER INSERT ON role_mentions
  FOR EACH ROW
  EXECUTE PROCEDURE role_mentions_after_insert();

CREATE TRIGGER messages_after_delete
  AFTER DELETE ON messages
  FOR EACH ROW
  EXECUTE PROCEDURE messages_after_delete();

CREATE TRIGGER messages_after_insert
  AFTER INSERT ON messages
  FOR EACH ROW
  EXECUTE PROCEDURE messages_after_insert();

CREATE TRIGGER messages_after_update_edited_timestamp
  AFTER UPDATE OF edited_timestamp ON messages
  FOR EACH ROW
  EXECUTE PROCEDURE messages_after_update_edited_timestamp();
