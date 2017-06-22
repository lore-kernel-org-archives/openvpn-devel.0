From: James Bekkema <james@...1918...>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Thu, 22 Jun 2017 10:17:22 +1000
References: <c129e755-6c9e-a35f-2958-84b44baa96f2@...515...>
	<8a543794-fa2e-cc1b-5db5-7cc9106d126b@...2080...>
In-Reply-To: <8a543794-fa2e-cc1b-5db5-7cc9106d126b@...2080...>
Message-Id: <89BEB5CA-98CB-47C4-8DBD-9160F5EE9554@...1918...>
Subject: Re: [Openvpn-devel] OpenVPN 2.4.3 released (with security fixes)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

> On 22 Jun 2017, at 7:06 am, David Sommerseth <openvpn@...2080...> wrote:
>=20
> - What can be done with Cloudflare to fully ensure their caches are
>  truly purged when we ask for it?  As Jonathan noticed, their caches
>  are tightly connected to the web browser and have a non-deterministic
>  behaviour across browsers, even on the same computer.

Cloudflare=E2=80=99s API supports clearing the cache (as does their web con=
trol panel), and this can be done on a file-by-file basis. Based on our exp=
erience it only takes around 15-20 seconds for the cache to be cleared on a=
ll of Cloudflare's CDN nodes for a file and it can be easily thrown into a =
release script.
https://api.cloudflare.com/#zone-purge-individual-files-by-url-and-cache-ta=
gs

As for some web browsers, proxy servers, etc. in-between the user and a Clo=
udflare node, they=E2=80=99re respecting the HTTP cache-control headers whi=
ch are currently set to cache for 24 hours:

curl -I https://swupdate.openvpn.org/community/releases/openvpn-2.4.3.tar.gz
Expires: Fri, 23 Jun 2017 00:14:19 GMT
Cache-Control: public, max-age=3D86400

Of course, many proxy servers and web browsers have different approaches to=
 handling caching headers (especially for zipped files), so you will get so=
me differing behaviour. The best approach is to still have an appropriate c=
aching time between nodes and the web server (24 hours is fine) so they don=
=E2=80=99t need to re-fetch the files too often, but then have a Cloudflare=
 Page Rule to rewrite these with a lower time to clients (we use 4 hours) t=
o limit the impact in the (hopefully rare) event of a file update being nee=
ded.
https://support.cloudflare.com/hc/en-us/articles/200168306-Is-there-a-tutor=
ial-for-Page-Rules-#cache

The final cause of differing behaviour is that each Cloudflare node=E2=80=
=99s caching time of a file starts when that individual node first gets a r=
equest for it. But this can easily be ignored by just using the API to clea=
r the cache of all nodes when needed.

> So I suggest we take a few weeks holiday, let this sink in, and then we
> can schedule a meeting some time in August where we discuss these
> issues.


Sorry to throw more noise at the mailing list, but I figured I=E2=80=99d pu=
t up some comments as IRC meeting times don=E2=80=99t usually align for tho=
se of us in Australia :-)

Regards,
James

--
James Bekkema
SparkLabs Developer
https://www.sparklabs.com
https://twitter.com/sparklabs
support@...1918...
