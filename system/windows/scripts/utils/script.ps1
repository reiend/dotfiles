function Show-Step() {
	param (
		$message = "installation - in progress"
	)

	Start-Sleep -Seconds 0.5
	clear
	Write-Host $message
	$step.Value++
	echo "Step $($step.value)/$($end.value)"
	Start-Sleep -Seconds 0.5
}

function Show-Finish() {
	clear
	echo "Step $($step.value)/$($end.value)"
	echo "Finish"

	Read-Host -Prompt "Press any key to continue"
	clear
}

function Start-Action {
	param (
		$action,
		$title,
		$message,
		$default = $YES.value
	)

	$choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
	$choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Yes', "Yes"))
	$choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList 'Yes to &All', "Yes to All"))
	$choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&No', "No" ))

	if($isYesToAllChoices.value) {
		& $action
		return
	}

	$choice = $Host.UI.PromptForChoice($title, $message, $choices, $default)

	switch($choice) {
		$YES.value {
			& $action
			break
		}
		$YES_TO_ALL.value {
			& $action
			$isYesToAllChoices.value = $true
			return
		}
		$NO.value {
			return
		}
	}
}

