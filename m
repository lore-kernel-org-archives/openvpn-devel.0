MIME-Version: 1.0
References: <20220218124149.149-1-lstipakov@...277...>
In-Reply-To: <20220218124149.149-1-lstipakov@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 21 Feb 2022 11:22:44 +0200
Message-ID: <CAGyAFMVOCdv0JiQfsLqm5kDqdwCAsX=zxT06UTMQvet7tP4nhA@...278...>
Subject: Re: [Openvpn-devel] [PATCH master+release/2.5] error.c: use correct
 API to get error description on Windows
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Cc: Lev Stipakov <lev@...515...>

We had a long discussion with ordex about this patch and came to the
conclusion that error printing is currently broken on Windows and
needs a proper fixing.

Why is it broken?

 - the bug that my patch fixes - we use Windows's GetLastError to get
Windows last error code and with that strerror to get C runtime error
description

 - we have code which uses M_ERRNO to get description of C runtime
errors, for example

    int fd = platform_open(filename, O_CREAT | O_TRUNC | O_WRONLY,
                           S_IRUSR | S_IWUSR);
    if (fd == -1)
    {
        msg(M_ERRNO, "Cannot open file '%s' for write", filename);
        return false;
    }

   but this doesn't really work, because msg(M_ERRNO) uses
GetLastError on Windows to get error code, and C runtime (in above
case it is _wopen) doesn't set the WinAPI's last error code.

 - we have code which uses M_ERRNO to print description of socket errors

    const ssize_t size = send(sd, buf, strlen(buf), MSG_NOSIGNAL);
    if (size != (ssize_t) strlen(buf))
    {
        msg(D_LINK_ERRORS | M_ERRNO, "send_line: TCP port write failed
on send()");
        return false;
    }

but in this case we should use WSAGetLastError on Windows and errno on
other platforms.

What we propose:

 - M_ERRNO prints only C runtime errors on all platforms and should be
only used with C runtime functions
 - We add M_WINERR which uses GetLastError and FormatMessage to print
Windows errors
 - We add M_SOCKERR, which is resolved into M_ERRNO on all platforms
except Windows and on Windows it is M_WSAERR. We use WSAGetLastError
and FormatMessage to print WSA errors. Socket functions use M_SOCKERR.

-Lev

