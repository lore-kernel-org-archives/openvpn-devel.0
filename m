References: <20200508114411.15762-1-davids@...515...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <9f285a71-23ad-7256-11b9-9a48d6971760@...2181...>
Date: Fri, 8 May 2020 22:59:23 +0200
MIME-Version: 1.0
In-Reply-To: <20200508114411.15762-1-davids@...515...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 2/2] options: Restore --tls-crypt-v2
 inline file capability
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
To: David Sommerseth <davids@...515...>, openvpn-devel@lists.sourceforge.net

Hi,

On 08/05/2020 13:44, David Sommerseth wrote:
> Commit cb2e9218f2bc73f re-factored the internal file handling, but
> somehow overlooked the --tls-crypt-v2 option processing.  It was no
> longer possible to load a configuration file with this key file inlined.
> 

maybe tls-crypt-v2 was not yet merged when my patch was conceived?

> There where two issues here.  First was that the OPT_P_INLINE flag was
> not set, so the option parser rejected --tls-crypt-v2 as inline capable.
> 
> Second issue was that the 'streq(p[1], INLINE_FILE_TAG)' check makes no
> longer sense, as at this point p[1] contains the file contents.  Instead
> use the is_inline flag.
> 
> Signed-off-by: David Sommerseth <davids@...515...>

Thanks a lot for fixing this too.

The change makes sense and just converts tls-crypt-v2 to the same
pattern as the other "inlineable" options.

I wonder if we should add unit-tests or t_client.sh test cases with
inlined files too.


Acked-by: Antonio Quartulli <a@...2181...>


-- 
Antonio Quartulli

