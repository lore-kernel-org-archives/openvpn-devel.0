Message-Id: <200209142140.g8ELejG07122@...41...>
From: "James Yonan" <jim@...41...>
Subject: [Openvpn-devel] OpenVPN Project Update
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sat Sep 14 14:41:02 2002
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net, openvpn-announce@lists.sourceforge.net

CURRENT STATUS
--------------

Here's an update on OpenVPN progress for the last two months...

1.3.1 appears to be very stable and there haven't been a lot of new patches recently, though having said that there are certainly a few, most notably a minor patch to enable NetBSD support, and better support for intermediate CAs.

WISH LIST
---------

The current wish list stands as follows:

(1) Forking server support
(2) Automatic Secure MTU discovery
(3) IPv6 endpoints or IPv6 over tun device
(4) Windows port

While none of these (with perhaps the exception of the last :) is rocket science, all require some work, and given that OpenVPN has reached a nice stability plateau, I'd like to hear your opinions on future directions in the development effort.

DONATIONS
---------

I'd also like to bring to your attention the fact that the OpenVPN project is now accepting donations.  Please consider a small donation (such as $20) if you are actively using OpenVPN and possibly more if you are deriving significant utility from the software.  Right now I am "between jobs" and therefore don't have as much time as I'd like to spend on open source, but with enough support from the user community I hope to forge ahead on more of the wish list.  Having said that, I'd like to emphasize that OpenVPN has been a team effort with many individuals now cited in the change log or offering support on the lists.  Still, there's a lot of less glamorous work required to keep an open source project alive, such as merging contributions, testing on multiple platforms, documentation, releases, web site and mailing list admin, tech support, answering questions, keeping up to date with libraries, staying on top of security issues, trying to figure out whether problem reports ar!
e bugs or operator error, etc. etc.  Those all add up to a significant time commitment, and bear in mind that even a small donation can go a long way towards funding this kind of work.

If you would like to donate, you can do so via pay-pal:

https://www.paypal.com/xclick/business=paypal%40yonan.net

I you have deeper pockets and want to make a more dramatic gesture, you might even consider hiring me :)  My resume is here:

http://openvpn.sourceforge.net/resume2002/

PRE-1.3.2 BETA AVAILABLE
------------------------

While there hasn't been a great deal of development activity over the past two months, there are a small number of low-impact patches waiting in the queue that I'd like to release.

Here's the change log:

* Added SSL_CTX_set_client_CA_list call
  to follow the canonical form for TLS initialization
  recommended by the OpenSSL docs.  This change allows
  better support for intermediate CAs and has no impact
  on security.
* Added build-inter script to easy-rsa package, to
  facilitate the generation of intermediate CAs.
* Ported to NetBSD (Dimitri Goldin).
* Fixed minor bug in easy-rsa/sign-req.  It refers to
  openssl.cnf file, instead of $KEY_CONFIG, like all
  other scripts (Ernesto Baschny).
* Added --days 3650 to the root CA generation command
  in the howto to override the woefully small 30 day
  default (Dominik 'Aeneas' Schnitzer).
* Added paypal links to website for project donations.
* Configured sourceforge mailing lists to require
  admin approval for non-member posts to reduce spam.

If you have time, are using TLS, and especially if you are using an intermediate CA, I would encourage you to test this beta and verify that the first point in the change log does not cause problems.

Download beta:

http://openvpn.sourceforge.net/beta/openvpn-1.3.1.4.tar.gz

SPAM
----

In other news, openvpn-users got its first spam the other day.  While spam certainly has not been a big problem here, I want to be as proactive as possible in keeping these lists from becoming spam vectors, so I've reconfigured the lists to require admin approval for non-member posts.  I'm willing to be the admin on this as long as it doesn't become a big time sink, and you can make life easier for me by subscribing before you post.

Thanks,
James Yonan
OpenVPN Project Leader




