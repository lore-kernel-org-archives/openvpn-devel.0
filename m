Message-Id: <1527828655.645316.1392609712.3E887A89@...2307...>
From: aclion@...2404...
MIME-Version: 1.0
In-Reply-To: <CAKuzo_iGmzY-D1Bn07fD89uWVuVDq-s622vtd21Tnn3oyuHF8A@...278...>
Date: Thu, 31 May 2018 21:50:55 -0700
References: <1527819161.492538.1392521184.3CB7A30B@...2307...>
 <CAKuzo_iGmzY-D1Bn07fD89uWVuVDq-s622vtd21Tnn3oyuHF8A@...278...>
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

Hi

On Thu, May 31, 2018, at 8:59 PM, Selva Nair wrote:
> It builds fine even with the openssl 1.1.1 dev branch:

Using OpenSSL libs installed in a FLAGS-specified, non-distro location?

Or are you using distro-installed libs?  Into distro locations?

Please share your flags and configure?

> >
> >                 When I switch to the OpenSSL version 1.1.1 libs, changing only the _FLAGS/_LIBS spec,
> >
> >         -       export OPENSSL_CFLAGS="-I/usr/local/include -I/opt/ssl11/include -I/usr/include"
> >         -       export OPENSSL_LIBS="-L/opt/ssl11/lib64 -Wl,-rpath,/opt/ssl11/lib64 -lssl -lcrypto"
> >         +       export OPENSSL_CFLAGS="-I/usr/local/include -I/opt/ssl11/include -I/usr/include"
> >         +       export OPENSSL_LIBS="-L/opt/ssl11/lib64 -Wl,-rpath,/opt/ssl11/lib64 -lssl -lcrypto"
> 
> 
> These two lines look identical to the two it replaces -- so what changed?

an obvious typo :-(

-       export OPENSSL_CFLAGS="-I/usr/local/include -I/opt/ssl10/include -I/usr/include"
-       export OPENSSL_LIBS="-L/opt/ssl10/lib64 -Wl,-rpath,/opt/ssl10/lib64 -lssl -lcrypto"
+       export OPENSSL_CFLAGS="-I/usr/local/include -I/opt/ssl11/include -I/usr/include"
+       export OPENSSL_LIBS="-L/opt/ssl11/lib64 -Wl,-rpath,/opt/ssl11/lib64 -lssl -lcrypto"

> Unable to find those functions in the headers and other similar errors
> point to something wrong/unusual with the openssl build. As if
> -DOPENSSL_API_COMPAT has been set to some large value (like
> 0x10100000L meaning 1.1). That should be left undefined (i.e., at its default,
> which I believe is 0).

No, OpenSSL 1.1.0 is configured with

    --api=1.1.0 \

as it should be to NOT have/use deprecated compat interfaces,

  https://www.openssl.org/news/openssl-1.1.0-notes.html
  "Deprecated interfaces can now be disabled at build time either relative to the latest release via the "no-deprecated" Configure argument, or via the "--api=1.1.0|1.0.0|0.9.8" option."

Apps linking against 1.1.0 should not be depending on the presence of deprecated libs' symbols via compat libs.

And again, if there was some 'problem' with the OpenSSL install, you'd expect to see it crop up somewhere else.

As I mentioned, I build lots of apps against these libs -- and the builds, and the executables, are problem-free.


- AC

