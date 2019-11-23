data Group = ToGroup {
    gName :: String,
    gMembers :: [String],
    gSongs :: [Song]
} deriving Show

data Song = ToSong {
    sName :: String
} deriving Show

data Album = ToAlbum {
    aName :: String,
    aSongs :: [Song],
    aOwner :: Group
} deriving Show

data Playlist = ToPlaylist {
    pName :: String,
    pSongs :: [Song]
} deriving Show

data User = ToUser {
    uName :: String,
    uPlaylists :: [Playlist],
    uSongs :: [Song],
    uGroups :: [Group]
} deriving Show

createUser :: String -> User
createUser name = ToUser name [] [] []

createSong :: String -> Song
createSong name = ToSong name

createGroup :: String -> [String] -> [Song] -> Group
createGroup name members songs = ToGroup name members songs

createPlaylist :: String -> [Song] -> Playlist
createPlaylist name songs = ToPlaylist name songs

createAlbum :: String -> [Song] -> Group -> Album
createAlbum name songs owner = ToAlbum name songs owner

addSongsToPlaylist :: [Song] -> Playlist -> Playlist
addSongsToPlaylist songs playlist = ToPlaylist (pName (playlist)) (pSongs (playlist) ++ songs)

addSongsToUser :: [Song] -> User -> User
addSongsToUser songs user = ToUser (uName (user)) (uPlaylists (user)) (uSongs (user) ++ songs) (uGroups (user))

addPlaylistsToUser :: [Playlist] -> User -> User
addPlaylistsToUser playlists user = ToUser (uName (user)) ((uPlaylists (user)) ++ playlists) (uSongs (user)) (uGroups (user))