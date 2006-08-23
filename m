In-Reply-To: <eci4vd$hdf$1@...165...>
References: <3141E3B9-C8B1-497D-AF6C-81BEC64E45D7@...739...>	<20060823111436.GH29423@...740...>
	<A66CDCCE-8899-493D-91B8-6414DEADA612@...739...>
	<eci4vd$hdf$1@...165...>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=pgp-sha1; boundary="Apple-Mail-7--191813736"
Message-Id: <82B76DFF-49C6-43F8-AABE-80F71DA23183@...739...>
Content-Transfer-Encoding: 7bit
From: Landon Fuller <landonf@...739...>
Date: Wed, 23 Aug 2006 11:08:48 -0700
Subject: Re: [Openvpn-devel] [Openvpn-users] Announcing OpenVPN Auth-LDAP
	2.0-beta2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Charles Duffy <cduffy@...294...>, =?ISO-8859-1?Q?Pasi_K=E4rkk=E4inen?= <pasik@...124...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-7--191813736
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit


On Aug 23, 2006, at 10:58, Charles Duffy wrote:

> Landon Fuller wrote:
>> In terms of the existing plugin interface, however, this is not
>> currently feasible. There is no obvious way for the plugin to  
>> return a
>> path / setting to the openvpn instance from within
>> openvpn_plugin_func_v1().
>
> I'm under the impression that the plugin interface allows one to hook
> into client-connect and return client-specific directives via writing
> them to a file (the name of which is passed in the argv array),  
> similar
> to the mechanism used by regular hook scripts. Indeed, in
> OpenVPN-2.0.7's multi.c:1273, it appears to be creating a temporary
> filename for precisely that use.

Whoops, I totally missed that:
	       --client-connect script
               Run  script on client connection.  The script is  
passed the com-
               mon name and IP address of the just-authenticated  
client as  en-
               vironmental  variables  (see  environmental variable  
section be-
               low).  The script is also passed the pathname of a   
not-yet-cre-
               ated  temporary  file  as  $1 (i.e. the first command  
line argu-
               ment), to be used by the script to  pass  dynamically   
generated
               config file directives back to OpenVPN.

That's very handy. When I next have some free time, I'll take a look  
at adding support for specifying configuration directives on the  
basis of LDAP group membership.

Thanks!
-landonf

--Apple-Mail-7--191813736
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFE7Jm1lplZCE/15mMRAnnHAJ0SySzgt0Yvqgl2mcvmEEXnEcj/JACfWXu/
JNr5KMhljHL4NjMEn29ouX4=
=05PT
-----END PGP SIGNATURE-----

--Apple-Mail-7--191813736--

