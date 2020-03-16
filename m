References: <20200313130133.19045-1-samuli@...515...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <285d114f-89b4-992d-f8b1-5cec175994ca@...2080...>
Date: Mon, 16 Mar 2020 13:37:53 +0100
MIME-Version: 1.0
In-Reply-To: <20200313130133.19045-1-samuli@...515...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Document some limitations of
 --auth-user-pass
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
To: samuli@...515..., openvpn-devel@lists.sourceforge.net

On 13/03/2020 14:01, samuli@...515... wrote:
> From: Samuli Seppänen <samuli@...515...>
> 
> URL: https://community.openvpn.net/openvpn/ticket/757
> Signed-off-by: Samuli Seppänen <samuli@...515...>
> ---
>  doc/openvpn.8 | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index 864f94e8..9e54890e 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -4127,6 +4127,12 @@ The server configuration must specify an
>  .B \-\-auth\-user\-pass\-verify
>  script to verify the username/password provided by
>  the client.
> +
> +Note that OpenVPN GUI on Windows does not prompt for the
> +password if the file contains only the username. However,
> +OpenVPN versions from 2.4 up bundle OpenVPN GUI version 11
> +which is able to cache usernames and passwords internally.
> +

Could we rephrase this, to not live in the past.  This will go into master and
probably also release/2.4.  I also doubt anyone using man pages on 2.3 would
even read this.  If there are Windows users on 2.3, there are no excuse not to
upgrade - unless it's an enterprise deployment, where end users most likely
would not even care (they should anyway complain to their IT department
regardless, for using outdated security software).

I would just rephrase it to say:

  OpenVPN GUI v11 and newer uses its own internal username/password storage
  independent of the --auth-user-pass file provided.  The file argument is
  ignored on such installations.

(or something like that)

-- 
kind regards,

David Sommerseth
OpenVPN Inc


