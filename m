Message-ID: <d92e0840-e0c0-040b-cea2-bc8a9bca7df8@...2669...>
Date: Tue, 23 Aug 2022 16:07:24 +0200
MIME-Version: 1.0
From: Timo Rothenpieler <timo@...2669...>
References: <20220823120902.738-1-timo@...2669...>
 <20220823134218.895-1-timo@...2669...>
Content-Language: en-US
In-Reply-To: <20220823134218.895-1-timo@...2669...>
Subject: Re: [Openvpn-devel] [PATCH v2] GitHub Actions: Use Docker Images
 for Ubuntu test runs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 23/08/2022 15:42, Timo Rothenpieler wrote:
> +        run: docker exec ovpn -e DEBIAN_FRONTEND=noninteractive sh -c "apt update && apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev linux-libc-dev man2html libcmocka-dev python3-docutils build-essential pkgconf libtool automake autoconf iproute2 git ${SSLPKG} ${NLPKG}"

Still not 100% right unfortunately... the -e DEB... part needs to go 
before the image name, and after exec.

