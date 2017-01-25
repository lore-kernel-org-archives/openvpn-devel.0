From: David Sommerseth <davids@...515...>
Date: Wed, 25 Jan 2017 19:46:11 +0100
Message-Id: <20170125184611.9560-1-davids@...515...>
In-Reply-To: <20170124232344.7825-1-davids@...515...>
References: <20170124232344.7825-1-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH applied] systemd: Move the READY=1
	signalling to an earlier point
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: davids@...515...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I took the liberty to improve the commit message a little bit,
to make a few things clearer.

Your patch has been applied to the following branches

commit e83a8684f0a0d944e9d53cdad2b543cfd1b6fbae  (master)
commit 041fd6488434b5df01f86dd873b536a2b690ee13  (release/2.4)
Author: David Sommerseth
Date:   Wed Jan 25 00:23:44 2017 +0100

     systemd: Move the READY=1 signalling to an earlier point

     Trac: #827, #801
     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Acked-by: Christian Hesse <mail@...1798...>
     Message-Id: <20170124232344.7825-1-davids@...515...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13945.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYiPJxAAoJEIbPlEyWcf3yxH4QALLTpJeE7AYS5N+54cRbswIM
Qjw/rKIU5WUe7hf6R//H8HmsWWbhCddYMYojl1XRcLglUdGFm+fTWkTUIUAtEZIy
F9IeTQNVRBYKXoJ5pVWs+9MfCKrdP7tuaUOouqmpuaU3EUwOTwXb9jfDhdNmiQFP
bbE3LC5uv4/BMUK/nPWX/9bqfiUhRRhoOIgDeLBaz2opvBNhLzx4wZV5EPXIsHG0
i1/BKmaU4nlBtVdC0CnL3fuKo1rjoAM+gPqZK1RbZISOBuXXuSJPx9hbNwaY1tU9
Vnvzd4iGmDdjBmxRkjgCwtYcwGGSPR5CCTa0xttqBFAj9Ljp2ZkQECPMWHWbY2D5
3/nj1RhY//YV6iWQD4dgq/Xtnfhp5c9bW00vl8t3h7psiO1BbkrRyQBMvGX7McwS
BvrgXhL0b8E5YLYM45ZQfYeCeNHXlZRlAIVEV0eC6ZHvFKqkVlhsjDHMzwztgbyF
tydEp8vDQtpixIMccUDPtYdWx5OXEje/sR0394tymYwCoMlak4lF4ED2PXdzzkHB
Lf41uTgoGUFhw3qbEaIhhTvbRCYq/AfSi7ojn46zhVqy6YPUG6F5WC4oHRlrvB63
OgGDtN2+F4loKXCOnbMPGM0eT3TKx11ft/fwnCJuVH6RVW3hybanGEXr3wkvWy6C
B/PEIq+CSxztTxxY49OI
=dvhT
-----END PGP SIGNATURE-----

