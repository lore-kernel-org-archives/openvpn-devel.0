Reply-To: openvpn-devel@lists.sourceforge.net
References: <1496177444-18373-1-git-send-email-steffan@...1856...>
	<29f51139-a525-fd92-0fe1-195d308d2924@...2080...>
	<20170531070258.GC97029@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <ae93b702-4edd-6772-0f1d-ac9629589ee8@...2080...>
Date: Wed, 31 May 2017 11:14:33 +0200
MIME-Version: 1.0
In-Reply-To: <20170531070258.GC97029@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="I9mXpipx5OjbR9EuXAF0Q1RvBr8WlcKh0"
Subject: Re: [Openvpn-devel] [PATCH release/2.4] configure.ac: fix building
 against static openssl
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--I9mXpipx5OjbR9EuXAF0Q1RvBr8WlcKh0
Content-Type: multipart/mixed; boundary="eLONAjbC9jQoEXlDRTsJfAW9IviJ5UDwR";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net
Message-ID: <ae93b702-4edd-6772-0f1d-ac9629589ee8@...2080...>
Subject: Re: [Openvpn-devel] [PATCH release/2.4] configure.ac: fix building
 against static openssl
References: <1496177444-18373-1-git-send-email-steffan@...1856...>
 <29f51139-a525-fd92-0fe1-195d308d2924@...2080...>
 <20170531070258.GC97029@...1296...>
In-Reply-To: <20170531070258.GC97029@...1296...>

--eLONAjbC9jQoEXlDRTsJfAW9IviJ5UDwR
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 31/05/17 09:02, Gert Doering wrote:
> Hi,
>=20
> On Wed, May 31, 2017 at 02:31:40AM +0200, David Sommerseth wrote:
>> If we really do care for supporting 0.9.8, in release/2.4 - I can give
>> this an ACK.  Otherwise, I think it might be better to backport
>> 039a89c331e9b7998d804 + 79ea67f77ca3afe91222f.
>=20
> You are the one that objects most violently if we break users' expectatio=
ns

Yes and no.  In regards to end users, I am very careful.  In regards to
package maintainers, I am less weary as they won't distribute failing
builds to end users.  This change hits package building, not the end user.

And when we have had the policy (at least on the Linux side) that the
oldest supported library and build dependencies are what the oldest
officially supported RHEL release carries, then moving to OpenSSL 1.0.1
should not break anything.

When also considering that any releases older than OpenSSL 1.0.2 is not
supported by OpenSSL upstream [1], and OpenSSL 1.0.1 is supported by at
least Red Hat in RHEL for the lifetime of RHEL ... Then ditching 0.9.8
support makes even more sense.

[1] <https://www.openssl.org/policies/releasestrat.html>

If there are other OS/distros actively supporting, fixing and
backporting security fixes to 0.9.8, then I have no issues keeping 0.9.8
support.  But unless there are someone having this requirement, cleaning
up all the various OpenSSL hacks for unsupported version is fairly
sensible to me.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--eLONAjbC9jQoEXlDRTsJfAW9IviJ5UDwR--

--I9mXpipx5OjbR9EuXAF0Q1RvBr8WlcKh0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZLol+AAoJEIbPlEyWcf3yJiIP/iPdJ4eDTj8fKcwRJnkBauhe
qDgh4A49ulrwJBK3KZ0fxySlViorHuZNtgN0ZN8wX1md24GNhwQPNm6FG7Y9oXQT
jUfNZs7BCJfPIkzxrUysR4NmLNWRuA+dQPkvmT4Ze3ZwI7lmXyvOV5ViRIH52D/W
E+lHlIckmg1xBB5z+pmWZP/jWJNmlbkI+4dIRYaFyRFFwxPSE64EcuY89J7RLKN/
Vmh4Qb8a5epRHWXXTli0aZNOkx0wjSvLMxGMbW+AXbCU41g+zmRpBZku4n/0tsh7
4vsVGRdfId2uaOA3VLwmOykCLrQ7ewl16tXSGgfMt3YUh23Xum9dUqYtlax2QpKD
IPM5jbts+EwHvs9x6GUMP6d+c80OEVnlLA9zuiDE+YpViuUUYYNcF8Rb8xVv1WKP
n+q5XOY1PLEbfn9cwLHdiZLEjiaAyO5h7KdVTSwoHeIEBgbWiDYav/LIoqaIVLxJ
/HMnvhR0XSJT6FuHwVT+4tODtxBjel6++9iinJat5TmJkFBaRTkRmthxnzMmtW1l
RKkJmYu7252pL+yDyorec2vdagjnNqBfVJs/TF45QMr6yysA8KetsVArGzR08a7Z
wLfdlBl101L6g7S3mV1ib1AYcjLnb3uhUHEouxaUd6HeJzESSOQuiUxcxWxKz6jM
tfsmg8GapoQpbBqfP9Vd
=oWri
-----END PGP SIGNATURE-----

--I9mXpipx5OjbR9EuXAF0Q1RvBr8WlcKh0--

