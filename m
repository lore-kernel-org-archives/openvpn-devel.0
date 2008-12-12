Message-ID: <18396.65.118.50.246.1229115049.squirrel@...1166...>
Date: Fri, 12 Dec 2008 14:50:49 -0600 (CST)
From: "Daniel Johnson" <Progman2000@...1085...>
MIME-Version: 1.0
Subject: [Openvpn-devel] 2.1_rc13 & rc15 Segfault when client connects
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Pardon the lack of debug information, but the issue stopped and I
have not been able to make it repeat.  I hope to have packet
captures and better debugging the next time it happens.

We operate two main OpenVPN servers, Mercury and Gemini.  Both are
Slackware 12.1, kernel 2.6.25.3.  When this began yesterday
afternoon both were running v2.1_rc13.  Our systems randomly pick
the server to connect to.

Due to a configuration mistake, Mercury had not started OpenVPN
after a recent reboot.  I was testing a laptop and could not
connect at all.  This led me to discover Mercury's problem and
correct it.  Gemini's processes had segfaulted a few minutes
before, and my OpenVPN-checking cron job was about to fix it.

I still couldn't connect.  Found that the UDP process had segfaulted
on Mercury just after I walked away, and Gemini had died seconds
after the cronjob kicked it.  I observed this several times on both
servers.  An example syslog message:

  Mercury kernel: openvpn[3247]: segfault at 0 ip b7e211a3 sp
                   bfbc1a5c error 4 in libc-2.7.so[b7daf000+146000]

The 'ip' is consistently in the form b7???1a3, 'sp' is bf?????c.  The
hex string in brackets is consistent right of the '+'.

Upgraded Gemini to v2.1_rc15, no effect.  Set one of the servers to
"verb 4" instead of the usual "verb 3", but didn't see anything
interesting.  Eventually it occurred to me to see if a particular
PC was triggering this, and found that "S1550" was shown connecting
immediately before each segfault.  I removed S1550 from the list of
allowed certificates on Mercury and the crashes stopped.  Before I
could test re-allowing it, the user turned his computer off for the
night.

This morning I confirmed he was running v2.1_rc9.  I had it connect
and everything was normal.  I upgraded him to v2.1_rc13 and went on
with the day.  A few minutes later I noticed that a /different/
machine had just caused both servers to segfault (but only one time).
I don't know if the user gave up or what, but he later connected OK.
He is also running v2.1_rc9.

I've been slowly installing the client on computers, and have a half
dozen or so volunteer guinea pigs.  Until last night my greatest
problem was an occasional processes hang, which my cron script fixes.
Having both servers go down (nearly) simultaneously is distressing
when I'm basically ready for full deployment.

One (possibly) odd thing about my configuration is using the
auth-pam plugin and Samba to authenticate against our MS Active
Directory domain.  I can post complete config information if you'd
like.

Daniel Johnson
Progman2000@...1085...
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFJQs6N6vGcUBY+ge8RApPmAJ9ETfs1lOPBmZdv4+ejiQxkVKlYngCg0dSH
bucRds/dfwPjO7N5tsXZ/3E=
=Im34
-----END PGP SIGNATURE-----


