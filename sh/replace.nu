# Compatibility hack between GdPlanningAI and Juicee
rg -u -l "@export var action: Action" addons/juicee/effects/particle_effect.gd
| lines
| each { |file|
    open $file --raw
    | str replace --all "@export var action: Action" "@export var action: JuiceeParticleEffect.Action"
    | save -f $file
}

rg -u -l "@export var action: Action" addons/juicee/effects/set_active_effect.gd
| lines
| each { |file|
    open $file --raw
    | str replace --all "@export var action: Action" "@export var action: JuiceeSetActiveEffect.Action"
    | save -f $file
}

echo "Compatibility scripts executed."
