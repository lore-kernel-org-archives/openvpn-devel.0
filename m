From: Kristof Provost <kprovost@...2661...>
Date: Mon, 22 Aug 2022 11:28:33 +0200
Message-Id: <20220822092834.14231-1-kprovost@...2661...>
In-Reply-To: <202208201401.27KE12Cm014083@...2054...>
References: <20220812134154.16729-3-kprovost@...2661...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH]: FreeBSD networking cleanup
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

I’ll post a patch.

>  - any particular reason you used argv_printf() + argv_printf_cat(),
>    instead of just putting all into a single argv_printf() call?
>
Mostly that that’s what src/openvpn/networking_iproute2.c does too.  I
don’t have particularly strong feelings either way, so I’ll add that to
the upcoming patch.

>  - the "openvpn_execve_check()" messages state "route *add* command failed",
>    while it could be "del" as well.  Making this "proper" might not be
>    worth it, as it would need string manipulation (or "duplicate whole
>    message").
>
It might be nice to turn openvpn_execve_check() into a variadic function
so we could do this:

    status = openvpn_execve_check(&argv, NULL, 0,
                                  "ERROR: FreeBSD route %s command failed”, op);

But I think I’ll just remove the ‘add’, which makes the error message
make sense for both add and del.

Best regards,
Kristof



