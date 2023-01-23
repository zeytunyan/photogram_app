CREATE TABLE
    t_User(
        id TEXT NOT NULL PRIMARY KEY,
        nickName TEXT NOT NULL,
        fullName TEXT NOT NULL,
        profession TEXT,
        [status] TEXT,
        postsCount INTEGER,
        followersCount INTEGER,
        followingsCount INTEGER,
        avatarLink TEXT
    );
CREATE TABLE
    t_UserShort(
        id TEXT NOT NULL PRIMARY KEY,
        nickName TEXT NOT NULL,
        fullName TEXT NOT NULL,
        avatarLink TEXT
    );
CREATE TABLE
    t_Post(
        id TEXT NOT NULL PRIMARY KEY,
        [text] TEXT,
        authorId TEXT,
        created TEXT NOT NULL,
        [changed] TEXT,
        repostedId TEXT,
        repostsCount INTEGER,
        likesCount INTEGER,
        commentsCount INTEGER,
        FOREIGN KEY(authorId) REFERENCES t_User(id)
    );
CREATE TABLE
    t_PostContent(
        id TEXT NOT NULL PRIMARY KEY,
        [name] TEXT NOT NULL,
        mimeType TEXT NOT NULL,
        postId TEXT,
        contentLink TEXT,
        FOREIGN KEY(postId) REFERENCES t_Post(id)
    );