References: <20161209181303.20267-1-list@...1798...>
	<20161212194442.GQ78624@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <c1f570a7-8a47-e992-b868-103cef718ceb@...2080...>
Date: Tue, 13 Dec 2016 01:29:26 +0100
MIME-Version: 1.0
In-Reply-To: <20161212194442.GQ78624@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="xTPIiuFw02c6F8taSsqNbVN3rOEosS0qu"
Subject: Re: [Openvpn-devel] [PATCH 1/1] add more security features for
 systemd units
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Christian Hesse <list@...1798...>
Cc: Christian Hesse <mail@...1798...>, OpenVPN Development <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xTPIiuFw02c6F8taSsqNbVN3rOEosS0qu
Content-Type: multipart/mixed; boundary="8ktcPnptj10HbCSar9aIkoUTNEoL81mgI";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Gert Doering <gert@...1296...>, Christian Hesse <list@...1798...>
Cc: Christian Hesse <mail@...1798...>,
	OpenVPN Development <openvpn-devel@lists.sourceforge.net>
Message-ID: <c1f570a7-8a47-e992-b868-103cef718ceb@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] add more security features for
	systemd units
References: <20161209181303.20267-1-list@...1798...>
	<20161212194442.GQ78624@...1296...>
In-Reply-To: <20161212194442.GQ78624@...1296...>

--8ktcPnptj10HbCSar9aIkoUTNEoL81mgI
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 12/12/16 20:44, Gert Doering wrote:
> Hi,
>=20
> On Fri, Dec 09, 2016 at 07:13:03PM +0100, Christian Hesse wrote:
>> From: Christian Hesse <mail@...1798...>
>>
>> ProtectSystem=3Dstrict mounts the entire file system hierarchy read-only,
>> except for the API file system subtrees /dev, /proc and /sys (which can
>> be protected using PrivateDevices=3D, ProtectKernelTunables=3D,
>> ProtectControlGroups=3D).
>=20
> Unless the temp directories are still writeable, this will break=20
> server configs with --client-connect scripts or plugins trying to hand=20
> back config settings via temp files.

Agreed, we cannot have /tmp (or --tmp-dir) read-only.

However, I read up a bit on ProtectSystem=3D on RHEL7.  And on RHEL7
(shipping systemd-219) ProtectSystem=3D can only be 'full' or 'true' (it
is 'false'/off by default).  We cannot use any other values, as RHEL
defines the oldest distros we support, and RHEL7 is the oldest systemd
distro we will support in the future.

We can definitely use ProtectSystem=3Dtrue, as that ensure /usr and /boot
are read-only.  That is safe.  If using 'full', /etc is also made
read-only.  I personally think this makes sense too, as if you have any
state or log files, they should be placed under /var/log, {/var,}/run or
/var/lib.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--8ktcPnptj10HbCSar9aIkoUTNEoL81mgI--

--xTPIiuFw02c6F8taSsqNbVN3rOEosS0qu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYT0DmAAoJEIbPlEyWcf3yVM8P/A9gQjyBZItmhnEVSPsAqQ2Z
t5fy58Z0S5+d7f+Fn7S8XfqpKpTAoFDT7lYUgkoUa3kaWZ8v1YGUL3P/w+FKu8HB
YsNjEFwOd9ZqFF1zLFIHV58XbWPl8HITuFD6OP7Y9CFkAQAu1HwMn4p+YbmvBpk3
kPHga/Vk+hvchXTu6kakVv9RJE63YeMSpWBcyreqjbiLhyQ+V+kWTa+37SVXIAVG
yYW7GWDQ19m413Aj3NDMwN1dk988z2kn36Fp1iMIddI7Qiwnv47IANVcmI+mENvD
SSuZRywcOpe/aNG1IHEHGWpNEDrYkbH5fHNUBnI1/VN0ABoxCCgWyPL5jsKhwJWo
efPhZkbwPc40ofUnERLj8Yz4mPM7GSWvVp9oc3zZD+D4WQVy4rDqu8JxnFvHEEl/
lgTt9J2fQdYupp7zTBBP74SdnCgArDcWm4/pN8zwqxz1gUDHOmDcGDbFaCLMmfPe
MWGiNtFVSvmMMslbqVtrVTOK7OCLqDG6auTwC2eldwLIlQIJkbCAhYxldO1mq8gY
5rciHufvJ4fsULQow3JfyacL8rmGKib4v71rPRgF+GOKnS74lc0ZuSQhD4E4V2ts
Xb4ynFn9g8wCiHsx4H1ksrFB1EOYl3OQnSsdIWZt7X8dyTXVXalnhiSic6t8NN1B
jWm23FYR9AYCpqch1htN
=X3ka
-----END PGP SIGNATURE-----

--xTPIiuFw02c6F8taSsqNbVN3rOEosS0qu--

