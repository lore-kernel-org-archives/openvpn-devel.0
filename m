Message-ID: <2e08ab000803170615v5939a6cfy59719674aea7698f@...278...>
Date: Mon, 17 Mar 2008 14:15:03 +0100
From: "Christophe Vandeplas" <christophe@...1081...>
In-Reply-To: <9e0cf0bf0803170553y4ca5608v41a26130568ce8bb@...278...>
MIME-Version: 1.0
References: <47DD4B14.5060009@...1081...>
	<9e0cf0bf0803161105u71b7afc0tc90fed05da57f0dc@...278...>
	<2e08ab000803170102k5b4070baw43fb555e75e79bff@...278...>
	<9e0cf0bf0803170553y4ca5608v41a26130568ce8bb@...278...>
Subject: Re: [Openvpn-devel] patch pkcs11 dynamic key id detection
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: Peter Koch <pk@...1082...>, openvpn-devel@lists.sourceforge.net, James Yonan <jim@...41...>

On 3/17/08, Alon Bar-Lev <alon.barlev@...277...> wrote:
> On 3/17/08, Christophe Vandeplas <christophe@...1081...> wrote:
>  > >  So back to my original idea... Use the management interface to prompt
>  >  >  the user to select a certificate.
>  >
>  >
>  > What does that mean for the end-user? If I understand it correctly the
>  >  user will need to do the following:
>  >  - start tunnel/openvpn
>  >  - open webbrowser and select certificate
>  >  - enter key (where? webinterface?, cli?)
>
>
> No no no... The OpenVPN GUI should handle all this... Prompt the user
>  with a list of certificates for him to choose.
>  The OpenVPN GUI may also be improved to execute some helper script to
>  filter out the list.

Looks I misunderstood the management interface. I always understood it
was the web-management... What you are referring to looks great !!

>  >  The thing is that some implementations of middleware (the Belgian eID
>  >  middleware, based on opensc) prompts the user with a GUI windows for
>  >  entering the password. (at least on MS Windows, not on my mac).
>  >  This window is started from the opensc layer and thus independent of
>  >  the layer above (openvpn). (please correct me if I'm wrong)
>
> I believe you are wrong and referring to the CSP alternative. PKCS#11
>  provider should not issue UI.

I should take a deeper look in the sources of the belgian middleware
to confirm this theory...

>  >  Isn't it also a possibility to include both ways? If yes I think we
>  >  should rewrite it a little to prevent duplicate code as much as
>  >  possible...
>
>
> I don't understand why the management interface solution is not sufficient.

Just a misunderstanding from my side with the certificate
selector/management and a web-interface...
Having such a management (gui,cli) is a great idea.

A question might be: Is there need for a system like the patch I
wrote, knowing your management patch should be included?

Here's my likes-dislikes (like I understand it):
pkcs11-match:
- more code
+ transparent thingie for the end-user, no need to understand concepts
of certificates
pkcs11-magement:
+ user has choice of cert
- user has choice of cert

I'll have a deeper look at your management patch, maybe I can find a
way to add the pkcs11-match principle in your code with almost no
extra complexity and redundant code.
Do you think it's worth the effort? Or better wait for the results and
feedback from the management part?


Thanks for your interest and input !

Christophe

