References: <20210121172536.32500-1-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <9da2d2f4-c9a1-a896-e482-cf724378ac8c@...1227...>
Date: Thu, 21 Jan 2021 20:43:08 +0100
MIME-Version: 1.0
In-Reply-To: <20210121172536.32500-1-gert@...1296...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] clean up / rewrite
 sample-plugins/defer/simple.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Am 21.01.21 um 18:25 schrieb Gert Doering:
> If we ship something that we consider a form of documentation
> "this is how to write an OpenVPN plugin" it should meet our standards
> for secure and modern code.  This plugin did neither.
> 
>   - get rid of system() calls, especially those that enabled a
>     remote-root exploit if this code was used "as is"
> 
>   - change logging from printf() to OpenVPN's plugin_log()
> 
>   - this requires changing to openvpn_plugin_open_v3() to get
>     to the function pointers
> 
>   - change wacky "background and sleep in the shell call" to the
>     double-fork/waitpid model we use in plugins/auth-pam
>     (copy-paste code reuse)
> 
>   - OpenVPN 2.5 and later react badly to OPENVPN_PLUGIN_FUNC_ERROR
>     returns to OPENVPN_PLUGIN_ENABLE_PF calls (SIGSEGV crash), so
>     always return SUCCESS.  Only hook ENABLE_PF if that functionality
>     is actually requested ("setenv test_packet_filter NN").
> 
>   - change deeply-nested functions auth_user_pass_verify() and
>     tls_final() to use early-return style
> 
>   - actually make defered PF setup *work* with recent OpenVPNs
>     (pre-creating temp files broke this, so unlink() the pre-created
>     file in the ENABLE_PF hook, and re-create asyncronously later)
> 
>   - add lots of comments explaining why we do things this way
>

> +    while( r>0 );

style ....

But overall it improves the sample plugin so massive that I think we
should merge it because it fixes several big issues.

Acked-By: Arne Schwabe <arne@...1227...>


