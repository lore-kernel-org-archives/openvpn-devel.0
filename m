From: Arkadiusz Patyk <areq@...104...>
Message-ID: <l2lrnv0jkbifdck1v5et75fh3r8t8lt26m@...105...>
MIME-Version: 1.0
Subject: [Openvpn-devel] (fwd) Re: Openvpn-users RSA Key  with password protection problem
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri Oct  3 13:02:06 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 03 Oct 2003 01:25:54 +0200, Stefano Bracalenti
<stefano.bracalenti@...114...> wrote:

On Thu, 2003-10-02 at 22:07, Arkadiusz Patyk wrote:
> Thu Oct 02 22:00:10 2003 0: OpenVPN 1.5-beta9 Win32-MinGW [SSL] [LZO]
> [MTU-DYNAMIC] built on Oct  1 2003
> Thu Oct 02 22:00:10 2003 1: Sorry but I can't read a password from the
> console because this operating system or C library doesn't support the
> getpass() function
> Thu Oct 02 22:00:10 2003 2: Exiting
> 
> ;-(
> 
> How can I  protect using password ?

You need the getpass() function. I use one from a libc windows
porting.
You can add something like this to win32.c:

---

char *
getpass (const char * prompt)
{
        static char input[256];
        HANDLE in;
        HANDLE err;
        DWORD  count;

        in = GetStdHandle (STD_INPUT_HANDLE);
        err = GetStdHandle (STD_ERROR_HANDLE);

        if (in == INVALID_HANDLE_VALUE || err == INVALID_HANDLE_VALUE)
                return NULL;

        if (WriteFile (err, prompt, strlen (prompt), &count, NULL))
        {
                int istty = (GetFileType (in) == FILE_TYPE_CHAR);
                DWORD old_flags;
                int rc;

                if (istty)
                {
                        if (GetConsoleMode (in, &old_flags))
                                SetConsoleMode (in, ENABLE_LINE_INPUT
|
ENABLE_PROCESSED_INPUT);
                        else
                                istty = 0;
                }
                rc = ReadFile (in, input, sizeof (input), &count,
NULL);
                if (count >= 2 && input[count - 2] == '\r')
                        input[count - 2] = '\0';
                else
                {
                        char buf[256];
                        while (ReadFile (in, buf, sizeof (buf),
&count,
NULL) > 0)
                                if (count >= 2 && buf[count - 2] ==
'\r')
                                        break;
                }
                WriteFile (err, "\r\n", 2, &count, NULL);
                if (istty)
                        SetConsoleMode (in, old_flags);
                if (rc)
                        return input;
        }

        return NULL;
}

---

Also remember to uncomment or insert if missing "#define HAVE_GETPASS
1"
in config-win32.h. Recompile and enjoy ;)

==============--

Is it possible to include this feature in next version?
-- 
Arkadiusz Patyk [areq(at)pld-linux.org] [http://rescuecd.pld-linux.org/]
[IRC:areq ICQ:16231667  GG:1383]  [AP3-6BONE] [AP14126-RIPE]

