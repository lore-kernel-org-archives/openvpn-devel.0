References: <20210317223448.1278818-1-tincanteksup@...277...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <4bd166a9-9433-5959-53d0-1f4ab4da28ae@...2181...>
Date: Wed, 17 Mar 2021 23:57:32 +0100
MIME-Version: 1.0
In-Reply-To: <20210317223448.1278818-1-tincanteksup@...277...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Do not print Diffy Hellman parameters
 file to log file
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
To: Richard Bonhomme <tincanteksup@...277...>, openvpn-devel@lists.sourceforge.net

Hi,

On 17/03/2021 23:34, Richard Bonhomme wrote:
> Suppress printing the complete Diffy Hellman parameters file
> to the log file when it has been configured as an inline file.
> 
> Signed-off-by: Richard Bonhomme <tincanteksup@...277...>

This is indeed something that I forgot to change when implementing
19fab1f6cf71715f84d09d6a8b49698b0ae42cd1

Like all other params that have an xx_inline bool companion, also
dh_file should be printed using the SHOW_STR_INLINE() macro.

Thanks for noticing and fixing this!

Acked-by: Antonio Quartulli <antonio@...515...>



-- 
Antonio Quartulli

