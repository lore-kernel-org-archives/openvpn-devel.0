References: <20210307161547.25130-1-gert@...1296...>
 <CAKuzo_iG4RfV+u1e5_qtgeet0p8Ne5UvCZNL4afnuPpavdLtGQ@...278...>
 <20210307181002.GQ976@...1296...>
 <CAKuzo_gecRK0fkWToNRuc7oGK==cZQnLFn08_6_C5MERMBKTJQ@...278...>
 <20210307184402.GS976@...1296...>
 <CAKuzo_huZkMc1LhG7abCBKn0TK17JR_TLb3DyMeV1VYb5mNesQ@...278...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <8705fd32-3da3-dc88-c493-c3e21e1d969f@...277...>
Date: Sun, 7 Mar 2021 19:26:16 +0000
MIME-Version: 1.0
In-Reply-To: <CAKuzo_huZkMc1LhG7abCBKn0TK17JR_TLb3DyMeV1VYb5mNesQ@...278...>
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



On 07/03/2021 19:20, Selva Nair wrote:

> Rereading my comment on Trac #1059 I recall testing this and concluding
> 100MB enough for clients. On modern machines that's a low amount of memory
> --- not allowing swapout of 100MB should be acceptable.  For servers, I
> think there is no reliable limit that we could come up with.
> 
> Selva
> 

I recall, when testing with EC the min. required was 89MB.

R

