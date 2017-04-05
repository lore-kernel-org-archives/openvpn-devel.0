References: <ee5a8207241568cedcccc4f7f2ea5bc8.squirrel@...2257...>
	<b6bac00d6d7260eea944814b0c995806.squirrel@...2257...>
	<53a21cf3f4e04fcf5d6b9798e04be3ce.squirrel@...2257...>
	<20170404064534.GC93896@...1296...>
	<6b3b8a029cd8761642ac3f8174238aa2.squirrel@...2260...>
	<063244418e0b88138db5b490037cb7a4.squirrel@...2257...>
	<20170405065745.GI93896@...1296...>
	<c923cbd7-6876-dfcf-513c-f8bbba21f421@...1435...>
	<f4e7f2e8-5310-a982-ffb3-67c0f0abb3ec@...2080...>
	<e22e11f96343e7507b1270a30b37225d.squirrel@...2260...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <0208b3d5-961c-0b95-a6a9-7b5124829957@...2080...>
Date: Wed, 5 Apr 2017 16:18:22 +0200
MIME-Version: 1.0
In-Reply-To: <e22e11f96343e7507b1270a30b37225d.squirrel@...2260...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QOohaNjnItOhamBuqhjcI11WL84EJBciP"
Subject: Re: [Openvpn-devel] [PATCH v2] Add per session pseudo-random
 component to --reneg-sec intervals
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Matter <simon.matter@...2249...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QOohaNjnItOhamBuqhjcI11WL84EJBciP
Content-Type: multipart/mixed; boundary="mWFSube9KE1D9R93OxeAqoSae36Tugt41";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Simon Matter <simon.matter@...2249...>, openvpn-devel@lists.sourceforge.net
Message-ID: <0208b3d5-961c-0b95-a6a9-7b5124829957@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] Add per session pseudo-random
	component to --reneg-sec intervals
References: <ee5a8207241568cedcccc4f7f2ea5bc8.squirrel@...2257...>
	<b6bac00d6d7260eea944814b0c995806.squirrel@...2257...>
	<53a21cf3f4e04fcf5d6b9798e04be3ce.squirrel@...2257...>
	<20170404064534.GC93896@...1296...>
	<6b3b8a029cd8761642ac3f8174238aa2.squirrel@...2260...>
	<063244418e0b88138db5b490037cb7a4.squirrel@...2257...>
	<20170405065745.GI93896@...1296...>
	<c923cbd7-6876-dfcf-513c-f8bbba21f421@...1435...>
	<f4e7f2e8-5310-a982-ffb3-67c0f0abb3ec@...2080...>
	<e22e11f96343e7507b1270a30b37225d.squirrel@...2260...>
In-Reply-To: <e22e11f96343e7507b1270a30b37225d.squirrel@...2260...>

--mWFSube9KE1D9R93OxeAqoSae36Tugt41
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 05/04/17 14:36, Simon Matter wrote:
>> On 05/04/17 09:31, Steffan Karger wrote:
>>> Hi,
>>>
>>> On 05-04-17 08:57, Gert Doering wrote:
>>>> On Wed, Apr 05, 2017 at 06:34:34AM +0200, Simon Matter wrote:
>>>>> I've attached v2 now which works without any config change:
>>>> [..]
>>>>> I prefer this version as it allows everybody to profit from it without
>>>>> touching any config files.
>>>>
>>>> I can see the reasoning, but 25% feels a bit on the high side :-) - so
>>>> let the ratholing begin what the number should be.
>>>>
>>>> Steffan, any views from the crypto side of things?
>>>
>>> Not really.  I think the feature makes sense, and I like that this will
>>> only *substract* from the set time (so not exceed any set limits).
>>>
>>> (And I agree that 25% feels on the high side - my gut says somewhere
>>> around 10%, but I have no analysis to show why that would be better.
>>> I'll leave picking that number to you.)
>>
>> The default is 60 minutes.  With 25% that means a time window of 15
>> minutes, so reneg-sec will occur between 45-60 minutes.
>>
>> I see this can be too much for some sites, and perhaps too little on
>> sites which have many users.   With 10%, the reneg-window is reduced to
>> 54-60 minutes.  For larger sites, this is most likely too small of a
>> window - though far better than everyone at "exactly" 60 minutes.
>>
>> But I am also wondering if this randomness should only occur on the
>> first renegotiation.
>>
>> If you have a 6 minutes time window and 100 connected clients, there is
>> a big chance that at some point the randomness will cause a similar
>> congestion again, as multiple clients to have the same delay.  With 25%
>> that chance is lower, but the chance increases again with more clients.
>>
>> So what if this randomness instead only occurs on the _first_
>> negotiation and then respect the --regneg-sec setting?  Then clients
>> will somewhat spread out and then keep a certain predictable
>> renegotiation load.  And if using 17%, you get a time window of roughly
>> 10-11 minutes where renegotiation happens.  With 100 clients, that means
>> roughly (with a theoretical, ideal and even spread) 10 clients per
>> minute.  Which is more reasonable.  With 200 clients, it is still
>> getting crowded but not too bad.
>>
>> But all that said ... I think it would be wise to have an optional
>> argument to --reneg-sec (in addition to the 'sec' argument we have
>> today) which can be used to further open or close this time window.
>> Larger sites will most likely want a larger time window than smaller one=
s.
>>
>> Btw ... is --reneg-sec pushable?  (Too lazy to check the code, man page
>> says "no").  If not, it would probably be a good idea to enable that.
>=20
> As I understand it client and server have 60 min. by default. Whatever is
> configured, the smaller value wins. That means, bad clients can set their
> reneg-sec to very low values and trash the server on the other end. From
> the server side this looks more or less like a DDOS.

That's possible today as well .... so I don't fully follow why this is
interesting in regards to the randomness or push-ability of --reneg-sec.

This can be pulled much further.  If you have an OpenVPN server on TCP,
even that is susceptible to D/DoS attacks too, where even
--tls-{auth,crypt} won't protect you.  For UDP, --tls-{auth,crypt} does
provide a nice barrier - unless the attacker(s) have access to that.
There's not even a need to complete the full TLS negotiation.

The point is, if I ever wanted to D/DoS an OpenVPN server, I'd partially
implement the OpenVPN protocol in an attack tool to start and perhaps
complete the TLS handshake just to start over again.  This would be far
more efficient than to use OpenVPN itself.  This can be multi-thread,
kicking off thousands of connections in parallel, and then deploy that
on a variety of VMs around the world.  Have 64 such VMs initiating 1024
TCP connections each to any TCP based server in a loop - and the port
pool on the server is exhausted.

So I doubt any reasonable client would really knowingly set
 --reneg-sec 1 just for the bloody fun of it.  The tunnel would be close
to useless.  Unless you're a clueless, bored script kiddie with no
imagination (yes, I know, there's plenty of them too).

As a mitigation to such attacks, it is possible to deploy some firewall
rules (see the iptables recent module for example) to restrict how often
IP address may initiate connections to the server.

Bottom line is ... I don't see D/DoS being a real issue, especially not
in regards to --reneg-sec.

> In our environment we have set reneg-sec=3D0 on all clients because we wa=
nt
> the server to have control over it. That's fine because we have only
> trusted clients. Making it pushable could be a solution to overwrite bad
> settings in clients.

Yes, I think this makes sense.  If the client don't want it - it is
possible to deploy a --pull-filter in the local client configuration.

> A more radical solution was to just remove the option on the client side.

Probably not going to happen.  This implies that the client trust the
server.  While that is reasonable in some configurations (corporate or
private servers, fpr exampe), using a commercial VPN provider to avoid
Geo-blocking (or whatever reason they have) - this assumption might not
be equally true.

Plus it would break lots of already existing configurations.  We could
discuss making it a NOP on the client side. But that can be more painful
to tackle; the exact same option parser in OpenVPN is used for all
command line arguments, configuration files, CCD files and pushed
options - and I might have forgotten a few more handfuls of users.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--mWFSube9KE1D9R93OxeAqoSae36Tugt41--

--QOohaNjnItOhamBuqhjcI11WL84EJBciP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJY5Py1AAoJEIbPlEyWcf3yfyAQAKC84g9omXYsFNWB+hZWUD18
GKenv5Hmvt7wIrgGR9yZAY66LcWm7jWSk1vWGTxMGxrkFgSYQ26//yPzEocb1mg5
Mr8YerkvwOg9DDu4ds1fTfuROSArnd88OzzL2OxBilRRgAjjLC9VyQpaX7K+s8dw
J+V1hhf5GW0fDcA+4do05QC8iHsCLgVliedqZmRyUqZkWPpOeajtLYUe4brYuAhm
9k4JtCrB4iuqEAEaMTv3NtmTTzY4nox5tFEbRpz8XIfFTiGfigZCOgPz78iRvKNY
eAqUAGb+tnQAn6Cw/lSP4uHZv1DQlMuIseCjxC9jVXN04B/atkHJmfjv9gqSCeJ/
9wRS+PAS1nhKMVTZGdiGG6B2/HBc13CCXEguMImLENeWU8X5zCLwGWtcprLnIP1e
MUHKn2SVcYP1VU23lcydgqFR5JFVJUhtSLL9hWLwGMa0pbeXSJI2eu+HST2sXM0F
q9taQZj8nlIaVBbWl/HCy7I4D5ozA58QpFVKH3kZTqzcvh01PdBox7uG5YzBoBci
xuINiM7YLMR0yns1uOyhoih/Gf8+AsXaQXSEO+yfMeifMWpquatorAd2ADWPyrpr
PY1AjrDZJSoJgWhuTSecGJHEKn8sFjJRg9vTkoHfmpdNTXe4AvOghCYT7prpDNXS
YVCI1CBGypGQFd9nLNyt
=Riuq
-----END PGP SIGNATURE-----

--QOohaNjnItOhamBuqhjcI11WL84EJBciP--

