public func createOne(userId: UserId, profile: NewProfile) {
  hashMap.put(userId, makeProfile(userId, profile));
};