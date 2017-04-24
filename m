References: <1492699272.18647.3.camel@...2264...>
	<0e3d6163-c8bb-bf76-1012-59dcfd264783@...1856...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <ba72e2ca-d020-f4f2-e33c-2af2798a5f48@...2080...>
Date: Mon, 24 Apr 2017 13:15:51 +0200
MIME-Version: 1.0
In-Reply-To: <0e3d6163-c8bb-bf76-1012-59dcfd264783@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LxiINwLFQw2jMQdhtSPPoBKkK6d3sA4MO"
Subject: Re: [Openvpn-devel] [PATCH] Fix extract_x509_field_ssl for external
 objects
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LxiINwLFQw2jMQdhtSPPoBKkK6d3sA4MO
Content-Type: multipart/mixed; boundary="mNxoM8pbIAJEifx1TNfVuWr6GRF7HM9t8";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: openvpn-devel@lists.sourceforge.net
Cc: Steffan Karger <steffan@...1856...>
Message-ID: <ba72e2ca-d020-f4f2-e33c-2af2798a5f48@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Fix extract_x509_field_ssl for external
	objects
References: <1492699272.18647.3.camel@...2264...>
	<0e3d6163-c8bb-bf76-1012-59dcfd264783@...1856...>
In-Reply-To: <0e3d6163-c8bb-bf76-1012-59dcfd264783@...1856...>

--mNxoM8pbIAJEifx1TNfVuWr6GRF7HM9t8
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 23/04/17 10:59, Steffan Karger wrote:
> Hi,
>=20
> The change makes sense, so 'Feature-ACK', but one remark:
>=20
> On 20-04-17 16:41, Hristo Venev wrote:
>> @@ -191,16 +191,23 @@ extract_x509_field_ssl(X509_NAME *x509, const char=
 *field_name, char *out,
>>      X509_NAME_ENTRY *x509ne =3D 0;
>>      ASN1_STRING *asn1 =3D 0;
>>      unsigned char *buf =3D NULL;
>> -    int nid =3D OBJ_txt2nid(field_name);
>> +    ASN1_OBJECT *obj =3D OBJ_txt2obj(field_name, 0);
>> +
>> +    if (obj =3D=3D NULL)
>> +    {
>> +        crypto_msg(M_FATAL, "Cannot get ASN1_OBJECT for %s", field_name=
);
>> +    }
>=20
> M_FATAL is currently acceptable, because field_name always comes from
> the local config file, but I'd prefer to make this non-fatal, and return
> FAILURE.  That ensures that if someone decides to use this function in a
> way where field_name *is* attacker controlled, we do not introduce a
> remote DoS.
>=20
> As for the log level of this message: I think D_TLS_DEBUG_LOW (--verb 3)
> or possibly D_TLS_ERRORS (--verb 1) are appropriate.

Agreed!  I'm leaning towards D_TLS_ERRORS over D_TLS_DEBUG_LOW.  This
field is normally configured via the configuration file, IIUC (
like --x509-username-field).  So if this fails, it should have a very
low threshold of warning the sys-admin.  Normally, this shouldn't happen
unless a client is truly miss-configured.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--mNxoM8pbIAJEifx1TNfVuWr6GRF7HM9t8--

--LxiINwLFQw2jMQdhtSPPoBKkK6d3sA4MO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJY/d5xAAoJEIbPlEyWcf3yI+kP/jgVXE2e1ZpyJw9TIoq/30FF
Rdn3ZD6jyMnCjeOspVYpmUghph1lfO+bVMGnepGaJ6bL7NXkyy5SJgaraP3ouL74
GNnNGfZb3Z+0sI0ecYvLvbKILULRI+4RBadfDEbbSMb7JZ5mxA7ubO6ddM0+ICn6
eLBCVV52gsgyCX6zMrrfaL8wLWfCQaa+J0bNmKfd5fFhgv0LLIn91yhFQeE4OVzt
YPOuZg/hYQIPGVRdWc75ZqC+peJaNHDbbH0iFvAXCAYchvf/lMyWjbstByauViro
tYdvdTliIXMasHW9YNynkia3IWL30MbRjmWZW3YKdzf71Ry8KCP/VsDdbpBXKsuh
+Wk6qkRHbNC8T1eazAxLMoL++5+c7jEl9w4HD+KeDJbOQKBSIgdCGDgvrsPb2PVk
+iN4fh5nOMjNGu5mNnXXBirIsFe9r4q0pG/wVSbOTiIZlurDLmtUDJMr62WowjMT
Do2AWuo0IDif2rjKe7t0CVTLjviyTT4UXl9OL3N1rZ5lXtDscDHXOB3/YPzXvn4h
V2KsQfyz9x+xbndX0L2dpTj4STvyysQPU0RyQw09LbytmQ9uVEK7J/8Xzo+kKEIe
nFSdyIfYViPj38Gd400gl3NM74AAPIbvOZKUBgcnJHxDBRzrX0RcTfsk3n16Bc0Y
C0tKQJO4OLLgGopVtzZE
=KIIu
-----END PGP SIGNATURE-----

--LxiINwLFQw2jMQdhtSPPoBKkK6d3sA4MO--

