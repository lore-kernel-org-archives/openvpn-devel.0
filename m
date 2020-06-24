References: <cde19afd-b6cb-3b99-b346-1cfcdcebbbe2@...515...>
 <c31ed4c7-5451-cca7-1ba2-6a7a0eeecb59@...515...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <2fc54782-801b-ed64-deeb-de83ca3a131d@...2080...>
Date: Wed, 24 Jun 2020 13:48:23 +0200
MIME-Version: 1.0
In-Reply-To: <c31ed4c7-5451-cca7-1ba2-6a7a0eeecb59@...515...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] Summary of the community meeting (24th June
 2020)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

On 24/06/2020 13:10, Samuli Sepp=E4nen wrote:
[...snip...]
> Talked about the status of OpenVPN 2.5:
>=20
> <https://community.openvpn.net/openvpn/wiki/StatusOfOpenvpn25>
>=20
> Ordex promised to have a look at the async-cc patches this week.
> Plaisthos, dazo and cron2 will follow-up on the review comments to get
> them resolved quickly.
>=20
> OpenVPN 2.5 MSI looks surprisingly good. Mattock was able to produce
> tap-windows6 MSM ("merge module") which he then used to produce OpenVPN
> 2.5-based MSI installer. The only significant challenge is adding
> code-signing support to openvpn-build/generic.
>=20
> Automating MSI builds also seems easier than expected, given that the
> existing openvpn-build buildslave can perform the actual build and push
> the artifacts to the Windows packager, which can then build and push the
> results to build.openvpn.net.
>=20
> Code-vise 2.5-alpha1 is in a good shape, mainly missing

Just a nit-pick; we have not considered an alpha cycle for 2.5.  The first
beta will be released early July according to:
<https://community.openvpn.net/openvpn/wiki/StatusOfOpenvpn25>

> - compression
> - async cc
> - VRF (which is quite trivial)
>=20
> The auth-token fixes are corner-cases and it was agreed that that can be
> resolved between 2.5-alpha1 and 2.5-beta1.

That's also incorrect.  We will resolve these issues between the beta1 and =
rc1
releases.


--=20
kind regards,

David Sommerseth
OpenVPN Inc


