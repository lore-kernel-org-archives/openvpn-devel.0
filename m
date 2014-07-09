Message-ID: <53BD8113.6070401@...1856...>
Date: Wed, 09 Jul 2014 19:51:15 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <1403983176-27674-1-git-send-email-steffan@...1856...>	<53B1BDD8.8020705@...1856...>
	<53BBA8F9.30004@...1839...>
In-Reply-To: <53BBA8F9.30004@...1839...>
Subject: Re: [Openvpn-devel] [PATCH] Do not upcase x509-username-field for
 mixed-case arguments.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 08-07-14 10:16, Kalnozols, Andris wrote:
> Thanks, Steffan, for the comments and code cleanup.  Your method
> is definitely safer and has less clutter.  I tested your version
> and it works as intended.

Great, let's get the patch into git then.

> Regarding the "ext:" argument prefix, I had submitted an enhanced
> version of extract_x509_extension() mainly for more helpful log
> messages.  If it doesn't pass muster, then I would suggest that
> this function be at least changed as follows:
> 
>                     }
>                   break;
>                 default:
> -                 msg (D_TLS_ERRORS, "ASN1 ERROR: can not handle field
> type %i",
> +                 msg (D_TLS_DEBUG, "Ignoring name field type %i",
>                        name->type);
>                   break;
>               }
> 
> I don't see the need for alarm if an extension field has additional
> GeneralName field types other than "email".

Yeah, I simply didn't yet get to reviewing the extract_x509_extension()
patch, but I will get to that. I'm all in favour of more helpful log
messages. Just pushed it forward because it wasn't needed to fix a bug
:) I'll get back to you!

-Steffan

