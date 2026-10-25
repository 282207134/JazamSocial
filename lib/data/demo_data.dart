class Person {
  const Person(this.name, this.image, [this.detail = '3 mutual friends']);
  final String name, image, detail;
}

const friends = [
  Person('Bess Wilkerson', '0:210', 'Facebook'),
  Person('Norman Henry', '0:218', '4 mutual friends'),
  Person('Eliza Garza', '0:226', '8 mutual friends'),
  Person('Stanley Campbell', '0:234', 'Facebook'),
  Person('Cody Gonzalez', '0:242', '54 mutual friends'),
  Person('Jonathan Farmer', '0:250', 'Instagram'),
  Person('Russell Hayes', '0:258', 'WeChat'),
];
const contacts = [
  Person('Ellen Lambert', '0:907', "Hey! How’s it going?"),
  Person('Connor Frazier', '0:915', 'What kind of music do you like?'),
  Person('Josephine Gordon', '0:923', 'Sounds good to me!'),
  Person('Timothy Steele', '0:932', "Hi Tina. How’s your night going?"),
  Person('Lou Quinn', '0:939', 'What did you do over the weekend?'),
];
const online = [
  Person('Christopher', '0:950'), Person('Reese', '0:953'),
  Person('Jeffrey', '0:955'), Person('Laura', '0:957'), Person('Maldo', '0:959'),
];
const suggestions = [
  Person('Josie Johnston', '0:1035'), Person('Eddie Simmons', '0:1039'),
  Person('Noah Guzman', '0:1043'), Person('Allen Day', '0:1047'),
  Person('Bradley West', '0:1051'), Person('Jesus Reeves', '0:1055'),
];
const storyNames = ['Laura Quinn', 'Micheal Daws', 'Julian Fox'];
const storyImages = ['0:281', '0:297', '0:308'];
const channelImages = ['0:1122', '0:1126', '0:1130'];
const gallery = ['0:1461','0:1462','0:1463','0:1464','0:1465','0:1466','0:1468','0:1467','0:1469','0:1470','0:1471','0:1472'];
const travelCaption = 'If you are an infrequent traveler you may need some tips to keep the wife happy while you are jet setting around the globe.';
const europeCaption = 'Planning a vacation to Europe? No doubt you have certain expectations about your upcoming journey. Perhaps you’re the kind of person who expects to spend your days admiring amazing architecture.';

class SocialEvent {
  const SocialEvent(this.title, this.place, this.image, {this.date = 'SAT, JUN 15   7:30 PM'});
  final String title, place, image, date;
  Map<String, String> toJson() => {'title': title, 'place': place, 'image': image, 'date': date};
  factory SocialEvent.fromJson(Map<String, dynamic> json) => SocialEvent(json['title'] as String, json['place'] as String, json['image'] as String, date: json['date'] as String);
}
const events = [
  SocialEvent('Jazz Night', 'The Square · San Francisco', '0:1706'),
  SocialEvent('Cupcakes Popup Shop', 'Bonpass’s Bakery · San Francisco', '0:1716'),
  SocialEvent('Sale Pro - Blind Sale', 'Market Street · San Francisco', '0:1726'),
];
