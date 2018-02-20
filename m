References: <20180220162231.28897-1-chipitsine@...277...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <ad6db0c5-49aa-60ee-957f-57c0f0512937@...1856...>
Date: Tue, 20 Feb 2018 21:37:44 +0100
MIME-Version: 1.0
In-Reply-To: <20180220162231.28897-1-chipitsine@...277...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] travis-ci: add pkcs11-helper patch
 identical to openvpn-build
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

On 20-02-18 17:22, Ilya Shipitsin wrote:
> currently patch of implementing RFC7512 URI Scheme is added during
> building windows installer. The same patch was added to travis-ci
> cross builds

I don't think this is a good idea.  Most pkcs11-helper builds out in the
world are *without* this patch, so I'd rather test building against a
pkcs11-helper without the patch.

Also, we don't test pkcs11 functionality in this test suite at all, so I
don't see the gain in adding the patch here.

-Steffan

