Message-ID: <73d4841d-da95-f2a1-83fe-251b00754115@...2108...>
Date: Thu, 7 Nov 2024 12:10:29 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20241106165950.14469-1-michael.m.clarke@...277...>
From: David Sommerseth <dazo+openvpn@...2108...>
In-Reply-To: <20241106165950.14469-1-michael.m.clarke@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Allow auth plugins not to be invoked if
 other auth plugins fail
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Michael Clarke <michael.m.clarke@...277...>
Cc: Openvpn-devel@lists.sourceforge.net

On 06/11/2024 17:59, Michael Clarke wrote:
> The current authentication process loops through all plugins, invoking
> them each in turn, then returning a combined result from each
> invocation. This causes a challenge if multiple plugins are configured
> and a later plugin should only be executed if an earlier plugin
> succeeds - such as sending a Multi-factor authentication challenge only
> if a previous username/password verification succeeds - as the OpenVPN
> admin has no way of configuring a dependency between plugins, and
> plugins have no visibility of the current authentication state, so an
> MFA challenge would always be sent even on a password challenge failure
> in the stated scenario.
> 
> To overcome this, a system similar to Linux PAM's control flags is being
> introduced where auth plugins can be marked as one of four states:
> allows the plugin to fail without impacting other plugins whilst success
> of that plugin prevents any other plugins being run (sufficient),
> allow a plugin to fail whilst still then invoking certain other plugins
> before failing auth (required), allow a plugin's failure to abort the
> process immediately (requisite), or allow the plugin to be invoked but
> the result ignored (optional). For backwards compatibility plugins
> defined without a scope are treated as having a `required` scope.
> Attempting to specify a scope for a plugin that does not return
> an `OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY` mask will result in server
> startup aborting with an error, as will attempting to specify
> `sufficient` plugins after other auth plugins. For simplicity, any
> auth plugin that returns a deferred result but isn't specified as being
> a `required` scope will result in a server abort so that any subsequent
> plugins in the configuration aren't making an assumption about the
> deferred result.
> 
> To maintain backwards compatibility for plugins being invoked, the
> plugin scope is dropped from the command arguments passed to the plugin
> initialisation although the plugin binary path continues to be retained.


This RFC makes a lot of sense on a conceptual level.  But I'm not sure 
it's advisable to change the "plugin" option too much in the core of 
OpenVPN.  As Arne points out, backwards compatibility and ambiguities 
can be some nasty traps.  And there are plenty of relations between 
plug-ins and the script hooks in the code base - which would also need 
to be handled.

What I would suggest is actually to instead add a new plug-in, using the 
v3 API.  This new plug-in can take a configuration file and load all the 
auth-plugins and treat each of them according to the requirements.  This 
plug-in would then give the final result back to OpenVPN.

The advantage with this approach is that it would not require any 
changes to OpenVPN itself and it could be used on older OpenVPN versions 
as well - since the authentication steps is handled in the plug-in.

And while I'm writing this ... I do wonder why the auth-pam.so [1] 
plug-in doesn't fit.  It should be possible to create your own PAM 
"profile" in /etc/pam.d, for example /etc/pam.d/openvpn-duo and then 
just use this in the OpenVPN config file:

     plugin openvpn-auth-pam.so openvpn-duo

The openvpn-duo "profile" could have the needed authentication steps for 
username/password and Duo, within the flexibility the PAM stack provides.

[1] <https://github.com/OpenVPN/openvpn/tree/master/src/plugins/auth-pam>

In regards to re-using the username/password authentication.  OpenVPN 
can cache this information already.  And it should be possible to 
trigger an re-authentication with just the dynamic challenge, but it 
might be auth-pam does not properly support that.

So I'm generally thinking that we should aim to keep the authentication 
itself pretty simple in OpenVPN itself and rather push the more 
demanding authentication requirements into separate modules/plug-ins 
which can solve that task better.  This gives a better flexibility while 
keeping the OpenVPN code itself simpler.  After all, OpenVPN itself only 
needs to know if an authentication failed or succeeded - in which order 
or which authentication requirements were fulfilled is not important for 
OpenVPN.  And that's what the current plug-in API already gives you.

If the auth-pam plug-in is not sufficient, I'd like to see some 
exploration if that could be improved - or by adding a new auth-plugin 
which OpenVPN can use, which solves this challenge better.

That's my 2cents.


--
kind regards,

David Sommerseth
OpenVPN Inc


