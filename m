Message-ID: <35272.64.217.16.45.1260667920.squirrel@...1166...>
Date: Sat, 12 Dec 2009 19:32:00 -0600 (CST)
From: "Daniel Johnson" <Progman2000@...1085...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Patch for plugin/auth-pam.c
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

David Sommerseth wrote:
> I just decided to do a quick review, I don't believe this has
> made it into openvpn-2.1.0.  But from what I see, I have one
> concern in regards to a potential memory leak.
>
> The pam_server() function receives a "message" which puts the
> information into a "static" memory area which is using struct
> user_pass.  This is fine.  Then it calls pam_auth() with a pointer
> to this memory region.
>
> The pam_auth() function calls my_conv(), and if this function
> gets a match on USERNAME or PASSWORD value in the block around
> line 562, it calls searchandreplace() which does a strdup().  This
> is dynamically allocated with strdup() and saved into return_value.
> But!  In line 569, you have this line:
>
>                 aresp[i].resp = strdup (return_value);
>
> I presume that the aresp[] struct is freed somehow, I have not dug
> into that now.  But you have here a double strdup() situation if you
> get a match on USERNAME or PASSWORD.  It's almost like saying:
>
>               char *ptr = strdup (strdup ("string"));
>               free(ptr);
>
> This code will give you a memory leak.
>
> Please confirm if my assumptions are correct.  I would probably
> suggest to move the strdup() on line 569 and skip using the
> return_value at all.  Just use aresp[i].resp directly.


OK, I think I'm following you.  It seems to me that the strdup()
isn't  even needed for the no-match case, but I'm leaving it in
there lest I break something.

http://thor.chguernsey.com/temp/auth-pam.patch2
http://thor.chguernsey.com/temp/auth-pam.patch2.sig
Patch MD5: 50c9ba7923fe9f60ef73c2d772c62a43 *auth-pam.patch2

Daniel Johnson
progman2000@...1085...
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFLJEJT6vGcUBY+ge8RAr2PAKD/ID2pAYgoCml3Vfofcm1Xt55T3ACg0138
cC0XIgm13q1xJMMIx13ISNM=
=wG3O
-----END PGP SIGNATURE-----




