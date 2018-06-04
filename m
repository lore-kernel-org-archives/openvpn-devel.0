Message-Id: <1528136599.2661838.1396063928.5934C084@...2307...>
From: aclion@...2404...
MIME-Version: 1.0
Date: Mon, 04 Jun 2018 11:23:19 -0700
References: <1527819161.492538.1392521184.3CB7A30B@...2307...>
 <CAKuzo_iGmzY-D1Bn07fD89uWVuVDq-s622vtd21Tnn3oyuHF8A@...278...>
 <1527828655.645316.1392609712.3E887A89@...2307...>
 <CAKuzo_ifdaAb-nGgc2Z51-505j+J+kb_FbkQoVNodjVQD-qJjQ@...278...>
In-Reply-To: <CAKuzo_ifdaAb-nGgc2Z51-505j+J+kb_FbkQoVNodjVQD-qJjQ@...278...>
Subject: Re: [Openvpn-devel] OpenVPN 2.5_git fails to build linked to
 OpenSSL v1.1.0 Works great linked to OpenSSL v1.0.2 ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On 5/31/18 10:33 PM, Selva Nair wrote:
> OpenVPN still supports openssl 1.0 and you can't build with api
> restricted to 1.1. At least not yet. So it will build only if you use
> the "default build" of OpenSSL 1.1. And should build with 1.1
> lib/headers in major distributions -- if not, there is a problem.

The "default build" does NOT include the deprecated functions:

https://wiki.openssl.org/index.php/OpenSSL_1.1.0_Changes

	Access to deprecated functions/macros has been removed by default. To enable access you must do two things. 1) Build OpenSSL with deprecation support (pass "enable-deprecated" as an argument to config) 2) Applications must define "OPENSSL_USE_DEPRECATED" before including OpenSSL header files

The (often sloppy) distros' builds are the 'non-default' builds.

Until such time as it does, it'd be helpful to note in OpenVPN docs/readme/etc that, for building against OpenSSL 110 libs, a NON-default build is required.

AC



