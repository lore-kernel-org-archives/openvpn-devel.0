Date: Tue, 18 Dec 2018 15:09:45 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20181218140945.GU962@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="8uTAhV+4XWOYVBfE"
Content-Disposition: inline
Subject: [Openvpn-devel] RfD: printing of port numbers on v6 addresses
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--8uTAhV+4XWOYVBfE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

somewhen before 2.4 we lost "printing of port numbers on v6 addresses"
- we used to dumbly print v6addr:port, leading to

  2001:db8::123:1194

which is less than clear on "is this a v6 address plus port 1194" or=20
"just a longer v6 address".  Now we just print 2001:db8::123 in things
like the log line prefix, with no port indication.

"The Internet" says there are two widely used conventions:

- One is "the URI format as per rfc3986", which would make this

     [2001:db8::123]:1194

  which is "IPv6 literal addresses are always enclosed in square brackets",
  and if the port is printed, it's tacked on with ":port".

- the other one is "what tcpdump and others do", tacking the port onto
  the v6 address with ".", so this would become:

     2001:db8::123.1194

  also unambiguous (even in the v4-compatible 2001:db8::1.2.3.4.1194=20
  form), though possibly confusing.  This is what RFC5952 has to offer
  (plus "2001:db8::1 port 80" and "2001:db8::1p80" and "#80") - see
  https://tools.ietf.org/html/rfc5952#section-6


I find most of these forms ugly, but I want to "repair" this issue - not=20
the least because our management interface has "kill client by IP+Port",
which is currently broken because we do not print the port number at
all... (it might still be broken due to the way it works internally,
but that's a new can of worms).

See also https://community.openvpn.net/openvpn/ticket/664 for more
background.


Opinions?

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--8uTAhV+4XWOYVBfE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJcGP+pAAoJEB2Cnv7KVigS2XoL/24OF3hBAu2lY0D4K+Hy9T8j
S9KwB4KEiXi+W/yMu3befMAgehAloQcOzsV0vWDeyczSBczb40NdF7IJKEfiXYnp
9SnP1aKN+2HIu62LxuVNRsozsyPSEzNyiMfEfhv3U+82221xOwFzDsx+SQOWefD4
LC6AnpyD19sxdzQCienefRZGSKIKMlUUW97/xHUpJ3MYVWArez3dlZLZ7aTAv4Tu
wL9CTqVAF+22AgCztQjjDOBnLzF+DRTZJ0HgaVpQvigd07+0EPiVZCH1jaDTMacH
LeilDH3NA/SGV5SdmRhhFTNR0IDBEkoLdwQ8jknuqNmv8iRvf7O8tumTFJquw1ch
ZSK5vONYgDe3aUrBQbB4nCTyiSVk/0v7j2uus7lDvKjiD2m/zSLMVn1Va46aIg9Q
kpjUksZH6hy5R22vyAE6p5Ztbnv27HSZjHoF3/elbLduEbaRFjwb3yl73rZjjLCT
E+kBa6lq4J6BivXB08yOCyc0QoH/16W0rdymWzxrjA==
=PvlV
-----END PGP SIGNATURE-----

--8uTAhV+4XWOYVBfE--

