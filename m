Message-ID: <4BC8D9B4.1050709@...1338...>
Date: Fri, 16 Apr 2010 23:42:12 +0200
From: Fabian Knittel <fabian.knittel@...1338...>
MIME-Version: 1.0
References: <1271449313-26315-1-git-send-email-openvpn.list@...1114...>
	<1271449313-26315-2-git-send-email-openvpn.list@...1114...>
In-Reply-To: <1271449313-26315-2-git-send-email-openvpn.list@...1114...>
Subject: Re: [Openvpn-devel] [PATCHv2 1/3] Harden create_temp_filename()
	(version 2)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: David Sommerseth <openvpn.list@...1114...>
Cc: James Yonan <james@...515...>, David Sommerseth <dazo@...384...>, Openvpn-devel@lists.sourceforge.net

Hi David,

David Sommerseth wrote:
> +    }
> +  while (attempts < 6);
>  
> -  return gen_path (directory, BSTR (&fname), gc);
> +  msg (M_FATAL, "Failed to create temporary file after %i attempts", attempts);
> +  return NULL;
>  }

I noticed something else ... if - hypothetically - someone manages to
guess our file names 5 times in a row, we abort the OpenVPN process.
Maybe that's a bit drastic?

If I understand M_FATAL correctly, msg() doesn't even return.  So
effectively, the create_temp_file() function never returns NULL, because
all error cases are currently fatal.

As you've apparently prepared the code for the NULL case in your 2/3
patch, I would suggest a non-fatal error code for at least the last case.

Cheers
Fabian

