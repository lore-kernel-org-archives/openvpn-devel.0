MIME-Version: 1.0
References: <20220514103717.235-1-timo@...2669...>
 <202208111003.27BA3jBP091528@...2054...>
 <YvoXzZNWGa49RJ6D@...1296...>
 <41d3a297-83f3-5b13-49f7-dd70b0d8daee@...2669...>
 <YvogFJdhB+8n3qrK@...1296...>
 <e7ad101d-4a46-72b2-7eec-5be5e8d636f4@...2669...>
 <YvokdcW8oF9ur/mm@...1296...>
In-Reply-To: <YvokdcW8oF9ur/mm@...1296...>
From: Steffan Karger <steffan@...1856...>
Date: Tue, 16 Aug 2022 11:16:50 +0200
Message-ID: <CAA1Abx+YF51w6QQJaFqrNL9s3Q_Gp08jiZR7-WLsbTQaUqmZhA@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: platform: Retain
 CAP_NET_ADMIN when dropping privileges
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: Timo Rothenpieler <timo@...2669...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Mon, 15 Aug 2022 at 12:50, Gert Doering <gert@...1296...> wrote:
> On Mon, Aug 15, 2022 at 12:40:55PM +0200, Timo Rothenpieler wrote:
> > or don't even try to retain capabilities, since
> > they're not needed either way. I'd prefer the later, since fewer
> > capabilities is generally better.
>
> I could see arguments for "we want to do the ifconfig/route setup in
> an --up script" - for example to do VRF/NetNS stuff that OpenVPN can not
> do itself.  So for these scenarios having the capability around would
> be useful (= thus, try-and-warn)...
>
> Different scenario, same options.  We don't always know what users want.

Let me just second the "fewer capabilities is generally better"
argument. CAP_NET_ADMIN is a broad set of effective capabilties and
has been a popular path for privilege escalation vulnerabilities in
the past. See for example these two recent CVEs:

CVE-2022-2586

    A use-after-free in the Netfilter subsystem may result in local
    privilege escalation for a user with the CAP_NET_ADMIN capability in
    any user or network namespace.

CVE-2022-2588

    Zhenpeng Lin discovered a use-after-free flaw in the cls_route
    filter implementation which may result in local privilege escalation
    for a user with the CAP_NET_ADMIN capability in any user or network
    namespace.

So I'm really not in favour of retaining CAP_NET_ADMIN "just in case".
I would even like to be able to not retain it at all.

-Steffan

