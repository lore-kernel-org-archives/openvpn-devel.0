References: <20170813205217.16736-1-chipitsine@...277...>
 <20170813205217.16736-2-chipitsine@...277...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <efccf463-749f-73d6-2c9c-94b17fc64f20@...1856...>
Date: Sat, 19 Aug 2017 10:30:02 +0200
MIME-Version: 1.0
In-Reply-To: <20170813205217.16736-2-chipitsine@...277...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 1/1] travis-ci: add libressl build for
 osx
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 13-08-17 22:52, Ilya Shipitsin wrote:
> Tunnelblick ships openvpn binary built with libressl
> (see https://github.com/Tunnelblick/Tunnelblick/issues/317 )

I'm a bit on the fence about this one.  We do not support libressl,
while including a libressl build in travis creates an image as if we do.
 On the other hand, it is useful to know when libressl builds break.
I'm leaning towards a NAK, to be perfectly clear about the state of our
libressl support: "we do not support it, we do not test it, using it is
completely at your own risk".

-Steffan

