References: <20210401082934.29922-1-gert@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <5fef37b9-42b0-315c-5132-addc57aadd44@...2181...>
Date: Thu, 1 Apr 2021 10:54:53 +0200
MIME-Version: 1.0
In-Reply-To: <20210401082934.29922-1-gert@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Get rid of last PLUGIN_DEF_AUTH #ifdef
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
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Hi,

On 01/04/2021 10:29, Gert Doering wrote:
> Commit 99d217b200 attempted to get rid of all #ifdef related to
> --disable-def-auth but one of them managed to hide.  Remove.
> 
> The effect of this is that the "openvpn_acf_...tmp" files get not
> removed after when an async auth plugin is in use.  This is can
> get very annoying on a busy server.
> 
> Trac: #1186
> 
> Signed-off-by: Gert Doering <gert@...1296...>

nice catch :-)

Another chapter for "why ifdefs can be problematic..even after we have
tried to get rid of them".

Compile tested on my CI and tested in a setup not having def-auth in use
to make sure it wouldn't create side effects.

Acked-by: Antonio Quartulli <antonio@...515...>


-- 
Antonio Quartulli

