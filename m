Message-ID: <4B23808D.40907@...515...>
Date: Sat, 12 Dec 2009 13:37:49 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1260552743.31755.0@...1207...> <4B22D2C8.5020703@...41...>
	<jwv8wd8g722.fsf-monnier+inbox@...1269...>
In-Reply-To: <jwv8wd8g722.fsf-monnier+inbox@...1269...>
Subject: Re: [Openvpn-devel] OpenVPN project organization
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Stefan Monnier ha scritto:
>> One the one hand people expect OpenVPN to be rock-solid in both=20
>> stability and security.  In order to maintain this standard of quality,=
=20
>> there needs to be a rigorous process of patch vetting.  On the other=20
>> hand, as an open source project, OpenVPN needs to be transparent and=20
>> open to contributions from the community.
>>=20=20=20=20=20
>
> That misses the main issue: you can reject most patches on some
> stability ground, but then as a contributor I'd like to know how to
> improve my patch to make it acceptable.
>=20=20=20
> E.g. my "fqdn route with fqdn's that map to multiple IPs" patch (which
> I consider to be a bug-fix rather than a feature addition) has been
> somewhat discussed but only w.r.t the functionality, not the actual
> code, so I have no idea what I need to do in order to have it
> be accepted.  This is frustrating.
>
> This said, as a maintainer of a Free Software package, I am quite aware
> that giving responding to all contributions (let alone giving good
> feedback) can be challenging.
>
>
>         Stefan
>=20=20=20
Very good points. The first challenge is reviewing patches. I guess many
problems can be spotted with a quick look on the patch. These problems
should communicated so that they can be fixed. And if the patch is
included, then we should communicate that, too. Otherwise the committer
might think his/her patch was rejected.

Now, if we want to maintain stability, we need some way to test the
patches. Automated tests could be used in many cases but building the
test cases takes time. In addition I don't think automated tests catch
nearly all problems, so manual testing is required. I'm not a specialist
in VCS systems but I guess a distributed VCS could help in this. What
are your thoughts on the testing procedures/tools? Fedora's Beaker suite
was mentioned earlier and it sounds interesting.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc




