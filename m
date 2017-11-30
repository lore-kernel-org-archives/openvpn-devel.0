Date: Thu, 30 Nov 2017 09:53:30 +0100
From: Bernhard Schmidt <berni@...376...>
Message-ID: <20171130085330.mftz2f3vnx53vrz6@...2352...>
References: <20171126141555.25930-1-steffan@...1856...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="q2ldn537vuhydwyr"
Content-Disposition: inline
In-Reply-To: <20171126141555.25930-1-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH 1/3] Fix --tls-version-min and
 --tls-version-max for OpenSSL 1.1+
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--q2ldn537vuhydwyr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In gmane.network.openvpn.devel, Steffan Karger wrote:

Hi Steffan,

> As described in <80e6b449-c536-dc87-7215-3693872bce5a@...376...> on
> the openvpn-devel mailing list, --tls-version-min no longer works with
> OpenSSL 1.1.  Kurt Roeckx posted in a debian bug report:
>
> "This is marked as important because if you switch to openssl 1.1.0
> the defaults minimum version in Debian is currently TLS 1.2 and
> you can't override it with the options that you're currently using
> (and are deprecated)."
>
> This patch is loosely based on the original patch by Kurt, but solves the
> issue by adding functions to openssl-compat.h, like we also did for all
> other openssl 1.1. breakage.  This results in not having to add more ifdefs
> in ssl_openssl.c and thus cleaner code.

I have forwarded your patch to Kurt and asked for feedback. See attached
mail.

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=873302#32

Bernhard

--q2ldn537vuhydwyr
Content-Type: message/rfc822
Content-Disposition: inline

Return-Path: <kurt@...2310...>
Delivered-To: berni+fwd.debian@...2353...
X-Virus-Scanned: Debian amavisd-new at mail.svr03.mucip.net
X-Spam-Flag: NO
X-Spam-Score: -1.901
X-Spam-Level: 
X-Spam-Status: No, score=-1.901 required=6.31 tests=[BAYES_00=-1.9,
	RP_MATCHES_RCVD=-0.001] autolearn=unavailable autolearn_force=no
X-Spam-ASN: 
Date: Wed, 29 Nov 2017 20:14:22 +0100
From: Kurt Roeckx <kurt@...2310...>
To: Bernhard Schmidt <berni@...334...>
Cc: 873302@...40...
Subject: Re: Bug#873302: openvpn: openssl 1.1 tls version support
Message-ID: <20171129191421.34g5bej736qn2quq@...2310...>
References: <20170826111850.zocxzmflz5gyxta3@...2310...>
 <f64fcbe1-f283-6b7b-6c15-94f9025412e5@...334...>
 <20170828164302.2z3nzk6sltogbnfn@...2310...>
 <3a712c09-3b47-4216-0901-557bffa5c7bc@...334...>
 <e55ad711-69b3-e556-fb9b-566d6c6b96c7@...334...>
MIME-Version: 1.0
In-Reply-To: <e55ad711-69b3-e556-fb9b-566d6c6b96c7@...334...>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Greylist: delayed 360 seconds by postgrey-1.36 at muffat; Wed, 29 Nov 2017 19:20:35 UTC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 29, 2017 at 03:36:14PM +0100, Bernhard Schmidt wrote:
> Hi Kurt,
> 
> Steffan has posted a patch for this that is losely based on yours. It is
> not merged yet, comments welcome.
> 
> https://sourceforge.net/p/openvpn/mailman/openvpn-devel/thread/20171126141555.25930-1-steffan%40karger.me/#msg36136873

I have some comments:
- It has:
+/* TLS Version defines are new in OpenSSL 1.1 */
+#ifndef TLS1_0_VERSION
+#define TLS1_0_VERSION 0x0301
+#endif
+#ifndef TLS1_1_VERSION
+#define TLS1_1_VERSION 0x0302
+#endif
+#ifndef TLS1_2_VERSION
+#define TLS1_2_VERSION 0x0303
+#endif

It's TLS1_VERSION (not TLS1_0_VERSION)

The defines all exist in at least 1.0.1, the version that added
support for TLS 1.1 and 1.2


- It calls SSL_CTX_set_min_proto_version() unconditionally,
  overriding the library default. In the 1.0.2 case SSLv2 and
  SSLv3 are then disabled, in the 1.1 case it could enable SSLv3.

- openssl_tls_version() should probably add SSL3_VERSION support.


Kurt


--q2ldn537vuhydwyr--

