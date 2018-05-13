References: <20180409091038.12348-1-chipitsine@...277...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <e086ca51-ac65-66a7-64f5-d38fcae16ce5@...1856...>
Date: Sun, 13 May 2018 20:00:46 +0200
MIME-Version: 1.0
In-Reply-To: <20180409091038.12348-1-chipitsine@...277...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] travis-ci: cleanup and upgrade ssl
 libraries
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

On 09-04-18 11:10, Ilya Shipitsin wrote:
> both "compiler" and "exclude" are redundant, so remove them

Makes sense.  Though now that you're touching this anyway, maybe also
add an OpenSSL 1.0.1 build?  Since that's the oldest OpenSSL version we
support in the master branch, that's an interesting version to test with CI.

-Steffan

