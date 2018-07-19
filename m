References: <CAEsd45Rd+5_NTeQ_E1C9wps89GWU6OfxQ5CdEFiN_HCO0=xaAQ@...278...>
 <CAKuzo_in_bBm1Y1rwU3rhFfuUP8o7j9iQH9vyjk9myT42tpBSg@...278...>
 <CAEsd45Tqb4nCQYe9_CKwr6YKdW4BoF3B-V=iQU=KXPnYDu8GJQ@...278...>
 <CAKuzo_hhoa_3xs0NSt7A7o-9WErqZEp+uvGv2XQi0FmJ10H9jw@...278...>
 <CAEsd45STfqNvTKFTcpJ8nsy0nfndfQHJ7dTD8iSRJFGQ5aE3Hg@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <85f99901-755a-0db3-ad2c-64401c77b639@...1227...>
Date: Thu, 19 Jul 2018 17:49:23 +0200
MIME-Version: 1.0
In-Reply-To: <CAEsd45STfqNvTKFTcpJ8nsy0nfndfQHJ7dTD8iSRJFGQ5aE3Hg@...278...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] Dynamic challenge/response questions
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
To: "Jonathan K. Bullard" <jkbullard@...277...>, Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Am 19.07.18 um 17:43 schrieb Jonathan K. Bullard:
> Thank you, Selva! (Now all I need to do is get it working!)
> 

If you do all that stuff, be sure to also look at static-challenge that
can be part of openvpn files, e.g.

static-challenge "Please enter your gauth code" 1

Arne

