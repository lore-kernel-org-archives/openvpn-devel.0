MIME-Version: 1.0
In-Reply-To: <8817069.bUavoJz72o@...1526...>
References: <1322057655-15463-1-git-send-email-heiko.hund@...1489...>
	<CAOazyz0mAOkx5VBBM2WDiCBQ-S6ikV++9ixQpdg4LCCJ0D1sLg@...278...>
	<8817069.bUavoJz72o@...1526...>
Date: Wed, 23 Nov 2011 19:48:54 +0200
Message-ID: <CAOazyz28XMMdKP+sYJn_bnMQ8-xVDzcp6iSznx37uXT9eKLRDA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] UTF-8 X.509 distinguished names
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
To: Heiko Hund <heiko.hund@...1489...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Wed, Nov 23, 2011 at 5:14 PM, Heiko Hund <heiko.hund@...1489...> wrote:
> On Wednesday 23 November 2011 14:53:06 Alon Bar-Lev wrote:
>> As this is inserted into environment, what happens if locale is not
>> unicode enabled?
>
> Then the script will receive funny looking strings depending on your locale's
> code page. However, this is nothing that's being introduced with this patch,
> as mentioned in the commit message 2627335 already puts UTF-8 user names and
> passwords into the environment.
>
>> I think this may break some configurations.
>
> Aren't the environments lacking UTF-8 locales broken with regards to non-ASCII
> characters anyways? As UTF-8 encoding doesn't change any character < 128 non-
> ASCII DNs, user names and password will be passed to scripts just like in the
> good old days.

Yes, there are many none unicode environments, and I am not sure what
this patch will behave in windows environment as it is SCS-2 not
UTF-8.
OpenVPN is also used in embedded systems, such as dd-wrt.com and other.

So I guess I would like to see unicode=true parameter on *NIX use
UTF-8, on Windows use UCS-2.

Alon.

