Reply-To: openvpn-devel@lists.sourceforge.net
References: <7860b0e6a671e51e0853cf7a351d874e@...2277...>
	<20170615074739.GI97029@...1296...>
	<1649446.B7buzjzcZ2@...2279...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <9e766589-ac6e-e418-1b07-41a2889e0a17@...2080...>
Date: Fri, 16 Jun 2017 00:01:03 +0200
MIME-Version: 1.0
In-Reply-To: <1649446.B7buzjzcZ2@...2279...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="99BDMLgCXbblub5HHAmtuUUmXr0mDuNRW"
Subject: Re: [Openvpn-devel] Bug or Feature? Username in environment in
 auth-user-pass-verify
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steven Haigh <netwiz@...2277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--99BDMLgCXbblub5HHAmtuUUmXr0mDuNRW
Content-Type: multipart/mixed; boundary="78VFoK7jRV4hE1vHAb38sEvwHE8SGqL3H";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steven Haigh <netwiz@...2277...>, openvpn-devel@lists.sourceforge.net
Message-ID: <9e766589-ac6e-e418-1b07-41a2889e0a17@...2080...>
Subject: Re: [Openvpn-devel] Bug or Feature? Username in environment in
 auth-user-pass-verify
References: <7860b0e6a671e51e0853cf7a351d874e@...2277...>
 <20170615074739.GI97029@...1296...>
 <1649446.B7buzjzcZ2@...2279...>
In-Reply-To: <1649446.B7buzjzcZ2@...2279...>

--78VFoK7jRV4hE1vHAb38sEvwHE8SGqL3H
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 15/06/17 18:11, Steven Haigh wrote:
> On Thursday, 15 June 2017 5:47:39 PM AEST Gert Doering wrote:
>> Hi,
>>
>> On Thu, Jun 15, 2017 at 12:50:40PM +1000, Steven Haigh wrote:
[...snip...]
>>
>> old:
>>
>>         else
>>         {
>>             setenv_str(session->opt->es, "username", up->username);
>>             setenv_str(session->opt->es, "password", up->password);
>>         }
>>
>> new:
>>
>>         else
>>         {
>>             setenv_str(session->opt->es, "password", up->password);
>>         }
>>         setenv_str(session->opt->es, "username", up->username);
>>
>> ... then it should show up in client-connect as well.
>=20
> I managed to track this down today.
>=20
> It seems the pam plugin sets the environment variable. As such, as soon a=
s I=20
> add the following line to the server config, the username variable appear=
s=20
> back in the environment for auth-user-pass-verify:
> 	plugin /usr/lib64/openvpn/plugins/openvpn-plugin-auth-pam.so openvpn

Ouch.

> After commenting this line out and restarting the daemon, the username en=
v=20
> variable is gone.
>=20
> That still poses the question, is a plugin supposed to be able to alter t=
he=20
> environment presented to the auth-user-pass-verify script?

You have discovered something I've not been thinking of.  But yes,
plug-ins can actually manage to do that if they manipulate the
environment pointer provided to it.  All plug-ins runs within the same
memory scope as the main OpenVPN process - in fact, plug-ins is a way to
extend the features of the core OpenVPN process.

That said ... this needs to be changed, I think it makes sense to take
some action to reduce this possibility.  By manipulating pointers
provided to you via the the plug-in interface, you can make the OpenVPN
process crash and burn ... and it is fairly easily.  If you manage to
modify memory regions too much so other OpenVPN data structures gets
corrupted, it will explode in interesting ways.

> If so, should these changes also be in the client-connect script?

That should not be possible.  There exist no direct API to modify the
environment variables from plug-ins, that is purely a side-effect if how
the memory buffers and pointers sent to plug-ins are handled.

> If not, the environment might need a reset before the auth-user-pass-veri=
fy=20
> script is called?
Either reset (which I think is harder) or to copy the information into
new fresh buffers which are discarded once the plug-ins returns.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--78VFoK7jRV4hE1vHAb38sEvwHE8SGqL3H--

--99BDMLgCXbblub5HHAmtuUUmXr0mDuNRW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZQwOfAAoJEIbPlEyWcf3ya8oQAMLp0F+zPcXWAsqwEVrtlsTr
RrGItoqJOvF0wCQcEGMAaUxzZfUFNeqcKymlgGl5/1fN1um10C5bgjrhjbyqf7ZE
ReeRHlzjNbEacFIjAwdwlQuJylMSop/5pqkCyk1sqsr5QM3M+5lmOnXzl8gP0HJn
5GazoU64dUYn9eHT6mM/XElVDTnUwbg5GyzAdNuzf3L9SiFEuk41qzFmJiuaTC1u
dMxQdHEp4i6nIF/DryrFBMg4JJ5nkDx7GUXLQMJt6FqYxUKlS8iUXA4Y8LS3U3an
jPX2w5ecWVU/7o1J3d5cgMsASvVHOZEvcjHCgTMiqfd44ZqzsayJ7ZxwsK7DHkem
2ozUK+/MNe6WFGMPJgM1QI5cJyLUquBe+VJzcLo6D26hsn6JL6jsLauttM5nqYFp
hucrcRvvJ8whSNjIMXi6+/zEy7YL++OHbnqp1NGidi1y7cM6OE0rlBDcm3g+hsIt
JtP/xMIu4nfx6Q1DeH1UKCgxiQjgtDmYQWoyaUy94tFgbBhkSV3CL2g2fFvdSlef
LlnMpQfD1mcpfhC9ktNpTodlW/V4D5CWEooPvpxKSANPBgY5+wwin5VSky+faQxh
6jCb91/O6LpT59L8HtcOA9beH0so7kZcu1T8q4swjcz3ATncc57SWVlE9dkVR5+A
G0d3rsNCguUpfnIf9Ntk
=3l4T
-----END PGP SIGNATURE-----

--99BDMLgCXbblub5HHAmtuUUmXr0mDuNRW--

