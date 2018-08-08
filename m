References: <nEV9l80I3peitTd26qmQFpeoaQbEO-IR74B1gOvCLv-IfvQKjNfL9UnZq1aWr20480nGcbkSnhA-mSGEI5kG7JBMsGpNbNf2FExV3CSzRf4=@protonmail.com>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <25d2fa7d-6a66-09a2-d44d-ac2d6eac5fe6@...277...>
Date: Wed, 8 Aug 2018 13:33:28 +0100
MIME-Version: 1.0
In-Reply-To: <nEV9l80I3peitTd26qmQFpeoaQbEO-IR74B1gOvCLv-IfvQKjNfL9UnZq1aWr20480nGcbkSnhA-mSGEI5kG7JBMsGpNbNf2FExV3CSzRf4=@protonmail.com>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v2] Clarify and expand management
 interface documentation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

I have had my arm twisted into doing some spell checking of docs.

There is one spelling error (an old over looked one)
which you could fix with this patch. (inline)


On 08/08/18 12:35, Jonathan K. Bullard via Openvpn-devel wrote:
> Clarify and expand the documentation for the management interface:
> 
> * Add examples of static and dynamic challenge/response sequences in
> the "COMMAND -- password and username" section.
> 
> * Expand the "Challenge/Response" section with more detail.
> 
> * Use "management interface client" throughout (instead of "management
> client", which was used in several places previously).
> 
> * Clarify when both a username and password are needed, not just a
> username or a password.
> 
> * Clarify that an exit with a fatal error for a dynamic C/R will occur
> only if "--auth-retry none" (the default) is in effect.
> 
> * Fix a typo. ("posesses" => "possesses").
> 
> Signed-off-by: Jonathan K. Bullard <jkbullard@...277...>
> ---
> v2:
>   * Incorporate Selva Nair’s suggestions (thanks!).
>   * Remove incorrect quotes in Example 8.
>   * Use "base 64" throughout instead of "base64".
> 
>   doc/management-notes.txt | 232 ++++++++++++++++++++++++++++++++---------------
>   1 file changed, 159 insertions(+), 73 deletions(-)
> 
> diff --git a/doc/management-notes.txt b/doc/management-notes.txt
> index 96470d0..3935715 100644
> --- a/doc/management-notes.txt
> +++ b/doc/management-notes.txt
> @@ -12,7 +12,8 @@ as a client or server.
> 
>   The management interface is implemented using a client/server TCP
>   connection or unix domain socket where OpenVPN will listen on a
> -provided IP address and port for incoming management client connections.
> +provided IP address and port for incoming management interface client
> +connections.
> 
>   The management protocol is currently cleartext without an explicit
>   security layer.  For this reason, it is recommended that the
> @@ -104,7 +105,7 @@ be in the list, and it will cause the management interface
>   to save the "forget-passwords" string in its list of echo
>   parameters.
> 
> -The management client can use "echo all" to output the full
> +The management interface client can use "echo all" to output the full
>   list of echoed parameters, "echo on" to turn on real-time
>   notification of echoed parameters via the ">ECHO:" prefix,
>   or "echo off" to turn off real-time notification.
> @@ -118,10 +119,10 @@ like this:
> 
>   Essentially the echo command allowed us to pass parameters from
>   the OpenVPN server to the OpenVPN client, and then to the
> -management client (such as a GUI).  The large integer is the
> +management interface client (such as a GUI).  The large integer is the
>   unix date/time when the echo parameter was received.
> 
> -If the management client had issued the command "echo on",
> +If the management interface client had issued the command "echo on",
>   it would have enabled real-time notifications of echo
>   parameters.  In this case, our "forget-passwords" message
>   would be output like this:
> @@ -141,8 +142,8 @@ COMMAND -- exit, quit
> 
>   Close the managment session, and resume listening on the

managment --> management

>   management port for connections from other clients. Currently,

