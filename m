MIME-Version: 1.0
In-Reply-To: <57584444.2090302@...277...>
References: <1465388443-15484-1-git-send-email-steffan@...1856...>
	<CAA1AbxJ0MQH6UL-b1Y+n_nE74Jw1C7fZeNqpsFkYyjt_UFBVXw@...278...>
	<5758352E.9030407@...277...>
	<fb02387f-1ca4-5fe6-2bc4-604aa3d45899@...1227...>
	<57584444.2090302@...277...>
From: Steffan Karger <steffan@...1856...>
Date: Wed, 8 Jun 2016 18:19:47 +0200
Message-ID: <CAA1Abx+AEO4GJQ357B-qfF-EhfBCbYjtNE=CxNUxrPx+5qDkoQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Add support for cipher negotiation
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
To: debbie10t <debbie10t@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Wed, Jun 8, 2016 at 6:13 PM, debbie10t <debbie10t@...277...> wrote:
> First downloaded the wrong repo .. Not sure what I did wrong .. nvm
>
> Second: This is where my git foo falls down .. tried:
> $ git clone https://github.com/syzzer/openvpn/tree/nego-squashed
> Cloning into 'nego-squashed'...
> fatal: repository
> 'https://github.com/syzzer/openvpn/tree/nego-squashed/' not found
>
> Finally i downloaded
> https://github.com/syzzer/openvpn/archive/nego-squashed.zip
> built ok .. (no snappy)
>
> Sorry to waste your time and thanks for you help

For future reference, you should have done:

   git clone https://github.com/syzzer/openvpn --branch nego-squashed

-Steffan

