MIME-Version: 1.0
References: <20181007215837.489-1-arne@...1227...>
 <20181031165222.5997-1-arne@...1227...>
In-Reply-To: <20181031165222.5997-1-arne@...1227...>
From: Steffan Karger <steffan@...1856...>
Date: Wed, 5 Dec 2018 11:51:27 +0100
Message-ID: <CAA1Abx+ghos2h8qatMhon+ojAUX18MKTbz+W_3T4TfVOGXLTww@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2 1/2] Make tls_version_max return the
 actual maximum version
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Wed, 31 Oct 2018 at 17:53, Arne Schwabe <arne@...1227...> wrote:
> Before OpenSSL 1.1.1 there could be no mismatch between
> compiled and actual OpenSSL version. With OpenSSL 1.1.1 we need
> runtime detection to detect the actual best TLS version supported.
>
> Allowing this runtime detection also allows removing some of the
> TLS 1.3/OpenSSL 1.1.1 #ifdefs
>
> Without this patch tls-min-version 1.3 or-highest will actually
> downgrade to TLS 1.3 in the "compiled with 1.1.0 and linked against
> 1.1.1" scenario.

"Downgrade to TLS 1.2", I guess?

But more fundamental: do want to support runtime-upgrading the TLS
library? Are we sure that this is the only place where this will
create unexpected behaviour? Does it even make sense to upgrade a
dependency to a version that contains all sorts of API/ABI changes and
then expect that you do not have to recompile? Honest questions; I
don't understand why one would want or do this.

-Steffan

