References: <20210328155748.GF976@...1296...>
 <20210328171151.12056-1-toivol@...277...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <196c4ce0-69e6-a9ea-f922-3e7f76c36fd1@...2181...>
Date: Wed, 31 Mar 2021 23:46:23 +0200
MIME-Version: 1.0
In-Reply-To: <20210328171151.12056-1-toivol@...277...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2] Stop using deprecated getpass()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?Q?T=c3=b5ivo_Leedj=c3=a4rv?= <toivol@...277...>, openvpn-devel@lists.sourceforge.net

Hi,

Thanks a lot for considering my suggestions.

On 28/03/2021 19:11, Tõivo Leedjärv wrote:
> The getpass() function is present in SUSv2, but marked LEGACY. It is
> removed in POSIX.1-2001. Additionally, on Solaris getpass() returns
> maximum 9 bytes. This will make longer passwords fail with no
> possibility for user to know what is happening.
> 
> This patch removes usage of getpass() completely and replaces it with
> direct implementation of what getpass() does: opens tty (existing code),
> outputs the prompt (existing code), turns off echoing (new code), reads
> one line (existing code shared with echoed mode), restores tty state
> (new code) and closes tty (existing code).
> 
> Patch v2: incorporate review feedback, incl. style fixes, merge
>           termios.h check in configure.ac with an existing
>           AC_CHECK_HEADERS, add error check and logging after
>           tcsettattr() when restoring tty settings
> 
> Signed-off-by: Tõivo Leedjärv <toivol@...277...>

The code looks good and it actually simplifies our get_console_input()
function.

It's agreed that termios is available on most (all?) systems supporting
tun interfaces, therefore it is a valid replacement for getpass(),
without making us worry about old platforms.


I tested this patch with a simple client-server setup:
* Client was configured with "--auth-user-pass" and was sending some
username/password.
* Server was configured with "--auth-user-pass-verify script via-env",
where script was just printing its full env.

I then verified that the input on the client reflected the output on the
server, also with some unicode chars, to be sure the new logic would
still handle characters only Davids may use in his passwords.

password=ciao@@@@
password=ééëëff
password=test²³¤€’¥×~~
password=Ð


Acked-by: Antonio Quartulli <antonio@...515...>


-- 
Antonio Quartulli

