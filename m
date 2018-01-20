References: <CAKuzo_jF_fHfcEPUXeo6WKWQ4tw7T72-cexEUda=USGd9Ref7g@...278...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <2e8cdc1d-ac4b-13bd-a16e-7888a84b22b2@...1856...>
Date: Sat, 20 Jan 2018 19:24:34 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_jF_fHfcEPUXeo6WKWQ4tw7T72-cexEUda=USGd9Ref7g@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] On testing with openssl 0.9.8
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 20-01-18 18:22, Selva Nair wrote:
> Does openvpn-vagrant include any VM provisioning with openssl-0.9.8?
> Until recently I had access to a few old debian boxes but now all
> updated and 0.9.8 testing is getting harder.

To test against various openssl versions, I statically compile against
them, like this:

git clone https://github.com/openssl/openssl.git --branch
OpenSSL_0_9_8-stable
git clone https://github.com/OpenVPN/openvpn.git --branch release/2.4

(cd openssl && ./config -v -d no-shared && make build_libs)

cd openvpn

autoreconf -vif

OPENSSL_CFLAGS="-I$(pwd)/../openssl/include" \
OPENSSL_LIBS="-L$(pwd)/../openssl -lssl -lcrypto -lpthread -ldl" \
./configure --enable-strict

make check

That of course doesn't catch platform-specific things, but it does catch
almost all issues we've encountered so far.

-Steffan

PS: it could be that libpthead and libdl are only needed for newer
openssl version, but I use the same scripts to build for all versions.

