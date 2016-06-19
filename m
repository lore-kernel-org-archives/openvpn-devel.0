References: <20160619194538.GR2563@...2120...> <20160619202139.GS2563@...2120...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <57672976.4070802@...2080...>
Date: Mon, 20 Jun 2016 01:23:34 +0200
MIME-Version: 1.0
In-Reply-To: <20160619202139.GS2563@...2120...>
Subject: Re: [Openvpn-devel] Adding "protocol static" to Linux routes?
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Samuel Thibault <samuel.thibault@...1817...>, openvpn-devel@lists.sourceforge.net

On 19/06/16 22:21, Samuel Thibault wrote:
> Samuel Thibault, on Sun 19 Jun 2016 21:45:38 +0200, wrote:
>> So we need the attached change, which just adds "protocol static", to
>> express that the routes created by openvpn are to override other
>> dynamic routing.
> 
> Of course, v6 needs it too.

Which platforms have this change been tested on?


-- 
kind regards,

David Sommerseth

