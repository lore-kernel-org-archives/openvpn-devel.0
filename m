Message-ID: <5287B192.2080109@...1085...>
Date: Sat, 16 Nov 2013 11:55:30 -0600
From: Josh Cepek <josh.cepek@...1085...>
MIME-Version: 1.0
References: <1384624401-27943-1-git-send-email-gert@...1296...>
In-Reply-To: <1384624401-27943-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Fix IPv6 examples in t_client.rc-sample
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

ACK. This makes the sample addressing match RFC3849 recommendations.

- --
Josh Cepek

On 11/16/13 11:53, Gert Doering wrote:
> IPv6 documentation prefix is 2001:db*8*:: (not :dba:), and the second
> test stanza variables need to end in _2, of course...
> 
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  tests/t_client.rc-sample | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQGcBAEBAgAGBQJSh7GSAAoJENcx2Xpgb9Rjm/EL/RVX+lwBPGoA1lGiGpJ6yvJg
/Gi6gHbBCXwBugizeVhe0wa1Y8VDmDDZrfs8sdL7U1MVVnCj0G1IisC6z2kW69AV
pstmWaUlID0G8nt5GfvQNodJzAyEHzF+M8yqxWGCs0Mo5EJAfWlW7tT5H/o/fzt0
BJeDRLLIqNhkbCG6VWyRlEb1nG9PAA2IW4W1FtPL1kHGpkQNlEkeWMGUbgzxpkNL
7dmQ5PgzmADBjHM1FlAjH7D4s9qvDsp9ZFV0wMCApIIJJfE080iJczuoJypEVTQ0
O4lZpxcRZVNyZw08dO2nzoqcu60IzxqB7jUJ8qtFdn1Gccz0PGG5Pjo7sWwGWaE/
OQgURId998HRr3iAQR9oLSf1BxueNoldTOcMRfTDDn1fa2yCj2ftbBoBc7dW8hJH
aasIDJq8R96t2jrwn2Cs4MWPp4TZ03IgqoLjVznKNWH017axfuQyZdNoLEdW+owJ
UDOHF1Wbuv8Cx+dmHfsdQ9Uhtbm28eADTeQEMZGVmg==
=HHwF
-----END PGP SIGNATURE-----

