References: <20210307161547.25130-1-gert@...1296...>
 <CAKuzo_iG4RfV+u1e5_qtgeet0p8Ne5UvCZNL4afnuPpavdLtGQ@...278...>
 <20210307181002.GQ976@...1296...>
 <CAKuzo_gecRK0fkWToNRuc7oGK==cZQnLFn08_6_C5MERMBKTJQ@...278...>
 <20210307184402.GS976@...1296...>
 <fd76a92c-aad1-53e1-f3fd-fe887be64a24@...1227...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <1a5d4ecf-ab54-3f1d-5867-1638a9a5a2f6@...277...>
Date: Mon, 8 Mar 2021 13:45:35 +0000
MIME-Version: 1.0
In-Reply-To: <fd76a92c-aad1-53e1-f3fd-fe887be64a24@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Require at least 20MB of mlock()-able
 memory if --mlock is used.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net



On 08/03/2021 08:06, Arne Schwabe wrote:

> Looking at this feature  from today's perspective, it feels like one of
> OpenVPN's boutique features. Was probably useful at some point but
> doesn't really make much sense today anymore. Esepcially with what is
> written in the manpage. Today you rather would use full disk encryption
> or disable swapping rather than to rely on OpenVPN's --mlock.
> 
> That being said I am against your patch, I am just wondering if that is
> a feature we need to keep at all.
> 

Having all openvpn data remain permanently in memory also offers
a (small) performance boost.

Your alternative offers would impact performance and be system wide.

Therefore, I for one disagree.

--

