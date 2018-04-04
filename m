Reply-To: openvpn-devel@lists.sourceforge.net
References: <CAFvKqoEvVYg87Vwu=E_Wp0cOk7qZfsgBoguiX5ToLMNqW4wKRw@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <cd251af2-9481-ce03-8849-8eeae44f7216@...2080...>
Date: Wed, 4 Apr 2018 18:50:29 +0200
MIME-Version: 1.0
In-Reply-To: <CAFvKqoEvVYg87Vwu=E_Wp0cOk7qZfsgBoguiX5ToLMNqW4wKRw@...278...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Send authentication failure reason
 between plugins
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
To: Janito Vaqueiro Filho <janito@...2382...>, openvpn-devel@lists.sourceforge.net

On 04/04/18 16:43, Janito Vaqueiro Filho wrote:
> This patch implements support for sending an authentication failure
> reason from a server plugin to a client plugin. Currently this can only
> be done using the management interface. To allow this to be done through
> the use of plugins, two changes were made.
> 
> The first change is to allow a plugin to set the failure reason through
> an approach similar to how deferred authentication is done. The reason
> should be written as a single line to an external file whose path is
> specified in the plugin environment variable "auth_failure_reason_file".
> 
> The second change introduces a new plugin event: "AUTH_FAILED". Plugins
> running in the client that register to receive this event are notified
> when an authentication failure is reported from the server. The
> authentication failure reason, if one was received, is set to the
> "auth_failed_reason" environment variable.
> 
> Signed-off-by: Janito Vaqueiro Ferreira Filho <janito@...2382...>

Thanks for the patch ... but I don't trust the transport of this patch, I get
a slightly different output when pulling the patch from patchwork:

   <https://patchwork.openvpn.net/patch/290/>

So I believe your GMail setup has corrupted this patch - and I see it is sent
both as text/plain and text/html.

Please try to resend it via 'git send-email' instead, that generally does not
cause such corruptions.


-- 
kind regards,

David Sommerseth
OpenVPN Inc


