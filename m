From: David Sommerseth <davids@...515...>
Date: Wed, 25 Jan 2017 19:52:03 +0100
Message-Id: <20170125185203.10467-1-davids@...515...>
In-Reply-To: <20161227221832.610-1-list@...1798...>
References: <20161227221832.610-1-list@...1798...>
Subject: Re: [Openvpn-devel] [PATCH applied] systemd: Add more security
	feature for systemd units
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
To: mail@...1798...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

ACK.  Tested this lightly with both server and client profiles,
and this seems to work very well.  Users having keys under
/home will probably complain.  But I do not think system wide
configurations should depend on keys in users' home directories.

Your patch has been applied to the following branches

commit 76096c605fcac4815674b6ae76ac1f31f03a8186  (master)
commit ba3ccaf92d379f8a2efad80cee7dc2806088f421  (release/2.4)
Author: Christian Hesse
Date:   Tue Dec 27 23:18:32 2016 +0100

     systemd: Add more security feature for systemd units

     Signed-off-by: Christian Hesse <mail@...1798...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20161227221832.610-1-list@...1798...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13743.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYiPPRAAoJEIbPlEyWcf3ymHAQAIuy8UXELqs4blJCs0IfHtOg
nALf1ALs+fvhQp7he+Z+wxmDT+QFL3mli53RXKZZGG8y+boWgRFkJ11PX4YzsCO9
KSJAWqbDRW+n9pp8uZ7q6D+uLeiO6ziKhEm6Jl2zln4FtTxi3pW8jUcONEdNwBtP
XSzJ7vdKAuiKGp8GvDm+uWpyjRJvpsClKynPvh2sN0bY6ERlkLDYKUMy37+1vDfc
HV6k1Rdwq7L4fVxbx9P6YWF/iKX3yuqTK1Qs99ZaZ7N4UE+QAYtuOtzDbAb+ISrN
fs7kOim2H5OZ8qfgYTosE6bRLP4mTEqgKX7zjYUMPWWZZgvrW3H9E4v/nGWupZxD
NaLIE+WELGDVZRnHMZRkVYCbK6zcPYyvfrehc2O/cKKNAtsIQLDe8NdiirpWsbRB
7+e/UCgIyvtPTxaf1FoVD0ENdyfGXT3EYRIuCsPA6Uk9C5vu3JpAhBnxhleaynE6
Vkh29k3lxBi/CHKsIa2DYYLqumrkwlI9TJ6FHSt7xR4zYkA92BZb2UKZGDkuCss7
g5wNrnxuswIaAgllsa7YSKkVSS41DhlUZG+flFnFLbodME5HatUJWokAqJzOzC7L
vH1SMR+AQGKRwV1YkEJYRsxYfKJFByViipoqHkStq70Bl7Qql2hGXS+qh8cC/bLK
WX35Il88WHshyCmcqI+d
=2/Wt
-----END PGP SIGNATURE-----

