Subject: Re: [Openvpn-devel] Certificate Wizard 0.3b - code-related feedback
References: <1100311165.30425.27.camel@...23...>
From: Florian Weimer <fw@...315...>
In-Reply-To: <1100311165.30425.27.camel@...23...> (Charles Duffy's message of
	"Fri, 12 Nov 2004 19:59:25 -0600")
Message-ID: <87pt2dn1do.fsf@...315...>
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue Nov 16 09:36:02 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
To: Charles Duffy <cduffy@...294...>
Cc: Vlada Macek <tuttle@...316...>, openvpn-devel@lists.sourceforge.net, it-staff@...296...

* Charles Duffy:

> @@ -242,8 +242,7 @@
>                 char buffer[MAXLINELEN+1];
>                 int errorCode = GetLastError();
>  
> -               snprintf(buffer, MAXLINELEN, _("Unable to copy '%s' to '%s' - error %d", 0), source, target, errorCode);
> -               strcat(buffer, ": %%s");
> +               snprintf(buffer, MAXLINELEN, _("Unable to copy '%s' to '%s' - error %d: %%s", 0), source, target, errorCode);
>                 DisplayErrorToUser(errorCode, _("Failure copying files", 0), buffer);
>                 return FALSE;
>         }
>


I believe that this is still wrong.  The variables source and target
might contain '%' characters, too.

In other places, the source code uses strncpy() in a lenient way.  You
might want to check these places and make sure that the buffer is
always NUL-terminated.

