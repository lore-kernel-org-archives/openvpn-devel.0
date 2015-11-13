MIME-Version: 1.0
In-Reply-To: <20151113152758.GS24952@...1296...>
References: <1447382487-26031-1-git-send-email-selva.nair@...277...>
	<20151113073802.GK24952@...1296...>
	<CAKuzo_iCjV9sa=7=+2cz7JLxYNQ6-K6QYFgv67u31=aV-fQrmQ@...278...>
	<20151113152758.GS24952@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 13 Nov 2015 10:34:49 -0500
Message-ID: <CAKuzo_hC4E1jXS_7t4D4C=w1SqE+G-efYAE8Wvfo1verMkwt4Q@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Do not hard-code windows systemroot in
	env_block
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On Fri, Nov 13, 2015 at 10:27 AM, Gert Doering <gert@...1296...> wrote:
>>
>> However, if the user specifies --win-sys some_cruft, win_sys_path will
>> get set to that "some_cruft" (in options.c). User is the king.
>
> Yes.  In this case, I do not worry at all - "you get what you ask for".

In the current setup its perfectly fine. But I am adding it to my list
of genies when the privilege separation aka iService can is
opened...:)

Selva

