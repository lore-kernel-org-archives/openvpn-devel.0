References: <1445277979-21591-1-git-send-email-gert@...1296...>
	<5625FF23.70203@...1400...>
	<20151020212827.GN22054@...1296...>
	<5626C540.2080907@...1114...> <56274788.6060801@...1227...>
	<5629EBF4.2060405@...2080...>
	<20151226221906.GY24952@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <f0248977-40a8-7e63-27b8-6c9134c090d5@...1227...>
Date: Sat, 26 Dec 2015 23:27:53 +0100
MIME-Version: 1.0
In-Reply-To: <20151226221906.GY24952@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Add option --push-suppress-ipv6 to stop
 sending IPv6 info to clients.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1
 


>
> So, you asked for it, you or Arne get to review this :-) - it's currently
> missing a man page entry, but the commit message explains how it works -
> just put

and a changlog entry :)
>
>
>   push-remove tun-ipv6
>   push-remove route-ipv6
>
> into your ccd/ file, and all options strings starting with one of these
> strings are removed.  Caveat: "push-remove route" will remove IPv4 and
> IPv6 routes, so to remove only IPv4 routes, use
>
>   push-remove 'route '

A sounds like more of a hack that anything.
>
>
> (our config parser is just magic :) )
>
> Missing in this patch is "openvpn.8" and you can't remove "ifconfig-ipv6"
> (or "ifconfig", for that matter) from the push list as these are not
normal
> options but special cased - but that is actually not very hard to add if
> you agree with the general direction.
>
> gert
>
> PS: merry christmas everyone :-)
>
+void
+push_remove_option (struct options *o, const char *p)
+{
+  msg( D_PUSH, "PUSH_REMOVE '%s'", p );
+
+  if (o && o->push_list.head )
+    {
+      struct gc_arena gc = gc_new ();

That gc is never gc'ed and is alos not used :)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (MingW32)
 
iEYEARECAAYFAlZ/FGgACgkQe8+cMNS4zRcOpgCfQdoyXJeE5w+aEfArX+3O002q
pGUAniqnoMlwXqsQLbGcO1UWT/bESiY8
=8ulD
-----END PGP SIGNATURE-----


