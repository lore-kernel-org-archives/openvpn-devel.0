MIME-Version: 1.0
In-Reply-To: <20171203211654.1044-1-simon@...2293...>
References: <CAKuzo_ivgZaJ5pDkn4jtoph51KyfV3p7oTm3Mws3TAw55-vmbQ@...278...>
 <20171203211654.1044-1-simon@...2293...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 4 Dec 2017 12:27:48 -0500
Message-ID: <CAKuzo_j=mv1vAQv3NX7MpcdUx6n6=oUW068Drt2+3EH5Nxy+kQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH v4] openvpnserv: Add support for
 multi-instances
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
To: Simon Rozman <simon@...2293...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

v4 looks good and passes my tests and "opinionated" demands.

Thanks, Simon.

On Sun, Dec 3, 2017 at 4:16 PM, Simon Rozman <simon@...2293...> wrote:
>
> While openvpn.exe can run multiple concurrent processes, openvpnserv.exe
> is usually only one single globally unique running process.
>
> This patch extends openvpnserv.exe to support multiple service instances
> in parallel allowing side-by-side OpenVPN installations.
>
> Alternate instances must be installed as `SERVICE_WIN32_OWN_PROCESS`
> (Type 0x10) and must use the newly introduced service command line
> parameter:
> -instance <name> <id>
> <name> can be `automatic` or `interactive`.
>
> - The service settings will be loaded from `HKLM\Software\OpenVPN<id>`
>   registry key.
>
> - The automatic service will use `openvpn<id>_exit_1` exit event.
>
> - The interactive service will accept requests on
>   `\\.\pipe\openvpn<id>\service` named pipe, and run IPC with
>   openvpn.exe on `\\.\pipe\openvpn<id>\service_<pid>`.
>
> This patch preserves backward compatibility, by defaulting to
> `SERVICE_WIN32_SHARE_PROCESS` and `<empty string>` as service ID.
> ---


Although this is a new feature, the original behaviour is unaffected and
the possibility of named instances will help projects like eduVPN use
official binary releases.

So, I recommend this for 2.4 as well..

Reviewed by: SelvaNair <selva.nair@...277...>
Acked-by: Selva Nair <selva.nair@...277...>

